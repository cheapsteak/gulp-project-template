browserify = require 'browserify'
chalk      = require 'chalk'
CSSmin     = require 'gulp-minify-css'
es         = require 'event-stream'
gulp       = require 'gulp'
gutil      = require 'gulp-util'
jade       = require 'gulp-jade'
livereload = require 'gulp-livereload'
nodemon    = require 'gulp-nodemon'
path       = require 'path'
prefix     = require 'gulp-autoprefixer'
prettyTime = require 'pretty-hrtime'
rename     = require 'gulp-rename'
source     = require 'vinyl-source-stream'
streamify  = require 'gulp-streamify'
stylus     = require 'gulp-stylus'
uglify     = require 'gulp-uglify'
watchify   = require 'watchify'

production = process.env.NODE_ENV is 'production'

paths =
  scripts:
    source: './src/main.coffee'
    destination: './public/js/'
    filename: 'bundle.js'
  templates:
    main: './src/index.jade'
    watch: './src/**/*.jade'
    destination: './public/'
  styles:
    source: './src/style.styl'
    watch: './src/**/*.styl'
    destination: './public/css/'
  assets:
    source: './src/assets/**/*.*'
    watch: './src/assets/**/*.*'
    destination: './public/'

handleError = (err) ->
  gutil.log err
  gutil.beep()
  this.emit 'end'

gulp.task 'scripts', ['templates'], ->

  bundle = browserify
    entries: [paths.scripts.source]
    extensions: ['.coffee']
    debug: not production

  build = bundle.bundle()
    .on 'error', handleError
    .pipe source paths.scripts.filename

  build.pipe(streamify(uglify())) if production

  build
    .pipe gulp.dest paths.scripts.destination

gulp.task 'templates', ->
  pipeline = gulp
    .src paths.templates.main
    .pipe jade pretty: not production

    .on 'error', handleError
    .pipe gulp.dest paths.templates.destination

  pipeline = pipeline.pipe livereload(auto: false) unless production

  pipeline

gulp.task 'styles', ->
  styles = gulp
    .src paths.styles.source
    .pipe stylus
      'include css': true

    .on 'error', handleError
    .pipe prefix 'last 2 versions', 'Chrome 34', 'Firefox 28', 'iOS 7'

  styles = styles.pipe(CSSmin()) if production
  styles = styles.pipe gulp.dest paths.styles.destination
  styles = styles.pipe livereload(auto: false) unless production
  styles

gulp.task 'assets', ->
  gulp
    .src paths.assets.source
    .pipe gulp.dest paths.assets.destination

gulp.task "server", ->
  nodemon
    script: 'server/server.coffee'
    ext: 'coffee'
    watch: 'server'

gulp.task 'watch', ->
  livereload.listen()

  gulp.watch paths.styles.watch, ['styles']
  gulp.watch paths.assets.watch, ['assets']

  bundle = watchify browserify
    entries: [paths.scripts.source]
    extensions: ['.coffee']
    debug: not production
    cache: {}
    packageCache: {}
    fullPaths: true

  bundle.on 'update', ->
    gutil.log "Starting '#{chalk.cyan 'rebundle'}'..."
    start = process.hrtime()
    build = bundle.bundle()
      .on 'error', handleError

      .pipe source paths.scripts.filename

    build
      .pipe gulp.dest paths.scripts.destination
      .pipe(livereload())
    gutil.log "Finished '#{chalk.cyan 'rebundle'}' after #{chalk.magenta prettyTime process.hrtime start}"

  .emit 'update'

gulp.task 'no-js', ['templates', 'styles', 'assets']
gulp.task 'build', ['scripts', 'no-js']
# scripts and watch conflict and will produce invalid js upon first run
# which is why the no-js task exists.
gulp.task 'default', ['watch', 'no-js', 'server']
