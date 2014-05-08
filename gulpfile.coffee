browserify = require 'browserify'
coffeeify  = require 'coffeeify'
CSSmin     = require 'gulp-minify-css'
gulp       = require 'gulp'
gutil      = require 'gulp-util'
jade       = require 'gulp-jade'
livereload = require 'gulp-livereload'
lr         = require 'tiny-lr'
nodeStatic = require 'node-static'
path       = require 'path'
plumber    = require 'gulp-plumber'
prefix     = require 'gulp-autoprefixer'
rename     = require 'gulp-rename'
source     = require 'vinyl-source-stream'
streamify  = require 'gulp-streamify'
stylus     = require 'gulp-stylus'
templates  = require 'gulp-angular-templatecache'
uglify     = require 'gulp-uglify'
watchify   = require 'watchify'
reloadServer = lr()

production = process.env.NODE_ENV is 'production'

paths =
  scripts:
    source: './src/coffee/main.coffee'
    destination: './public/js/'
    filename: 'bundle.js'
  templates:
    main: './src/jade/index.jade'
    source: './src/jade/**/*.jade'
    watch: './src/jade/**/*.jade'
    destination: './public/'
  styles:
    source: './src/stylus/style.styl'
    watch: './src/stylus/*.styl'
    destination: './public/css/'
  assets:
    source: './src/assets/**/*.*'
    watch: './src/assets/**/*.*'
    destination: './public/'

handleError = (err) ->
  gutil.log err
  gutil.beep()
  this.emit 'end'

gulp.task 'scripts', ->

  bundle = browserify
    entries: [paths.scripts.source]
    extensions: ['.coffee']

  build = bundle.bundle(debug: not production)
    .on 'error', handleError
    .pipe source paths.scripts.filename

  build.pipe(streamify(uglify())) if production

  build
    .pipe gulp.dest paths.scripts.destination

gulp.task 'templates', ->
  gulp
    .src paths.templates.main
    .pipe(jade(pretty: not production))
    .on 'error', handleError
    .pipe gulp.dest paths.templates.destination
    .pipe livereload(reloadServer)

  gulp
    .src([paths.templates.source, "!#{paths.templates.main}"])
    .pipe(jade(pretty: not production))
    .on 'error', handleError
    .pipe(templates('templates.js'))
    .pipe(gulp.dest('tmp'))
    .pipe livereload(reloadServer)

gulp.task 'styles', ->
  styles = gulp
    .src paths.styles.source
    .pipe(stylus({set: ['include css']}))
    .on 'error', handleError
    .pipe prefix 'last 2 versions', 'Chrome 34', 'Firefox 28', 'iOS 7'

  styles = styles.pipe(CSSmin()) if production

  styles.pipe gulp.dest paths.styles.destination
    .pipe livereload reloadServer

gulp.task 'assets', ->
  gulp
    .src paths.assets.source
    .pipe gulp.dest paths.assets.destination

gulp.task "server", ->
  staticFiles = new nodeStatic.Server './public'
  require('http').createServer (req, res) ->
    req.addListener 'end', ->
      staticFiles.serve req, res
    req.resume()
  .listen 9001

gulp.task "watch", ->
  reloadServer.listen 35729

  gulp.watch paths.templates.watch, ['templates']
  gulp.watch paths.styles.watch, ['styles']
  gulp.watch paths.assets.watch, ['assets']

  bundle = watchify
    entries: [paths.scripts.source]
    extensions: ['.coffee']

  bundle.on 'update', ->
    build = bundle.bundle(debug: not production)
      .on 'error', handleError

      .pipe source paths.scripts.filename

    build
      .pipe gulp.dest paths.scripts.destination
      .pipe(livereload(reloadServer))

  .emit 'update'

gulp.task "build", ['scripts', 'templates', 'styles', 'assets']
gulp.task "default", ["build", "watch", "server"]
