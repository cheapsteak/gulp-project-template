path       = require 'path'
gulp       = require 'gulp'
gutil      = require 'gulp-util'
jade       = require 'gulp-jade'
stylus     = require 'gulp-stylus'
CSSmin     = require 'gulp-minify-css'
browserify = require 'gulp-browserify'
rename     = require 'gulp-rename'
uglify     = require 'gulp-uglify'
coffeeify  = require 'coffeeify'
nodemon    = require 'gulp-nodemon'
lr         = require 'tiny-lr'
livereload = require 'gulp-livereload'
reloadServer = lr()

compileCoffee = (debug = false) ->
  bundle = gulp
    .src('./src/coffee/main.coffee', read: false)
    .pipe(browserify(debug: debug))
    .pipe(rename('bundle.js'))

  bundle.pipe(uglify()) unless debug

  bundle
    .pipe(gulp.dest('./public/js/'))
    .pipe(livereload(reloadServer))

compileJade = (debug = false) ->
  gulp
    .src('src/jade/*.jade')
    .pipe(jade(pretty: debug))
    .pipe(gulp.dest('public/'))
    .pipe livereload(reloadServer)

compileStylus = (debug = false) ->
  styles = gulp
    .src('src/stylus/style.styl')
    .pipe(stylus({set: ['include css']}))

  styles.pipe(CSSmin()) unless debug

  styles.pipe(gulp.dest('public/css/'))
    .pipe livereload reloadServer

copyAssets = (debug = false) ->
  gulp
    .src('src/assets/**/*.*')
    .pipe gulp.dest 'public/'

# Build tasks
gulp.task "jade-production", -> compileJade()
gulp.task 'stylus-production', ->compileStylus()
gulp.task 'coffee-production', -> compileCoffee()
gulp.task 'assets-production', -> copyAssets()

# Development tasks
gulp.task "jade", -> compileJade(true)
gulp.task 'stylus', -> compileStylus(true)
gulp.task 'coffee', -> compileCoffee(true)
gulp.task 'assets', -> copyAssets(true)

gulp.task "server", ->
  nodemon
    script: 'server/server.coffee'
    ext: 'coffee'

gulp.task "watch", ->
  reloadServer.listen 35729, (err) ->
    console.error err if err?

    gulp.watch "src/coffee/*.coffee", ["coffee"]
    gulp.watch "src/jade/*.jade", ["jade"]
    gulp.watch "src/stylus/*.styl", ["stylus"]
    gulp.watch "src/assets/**/*.*", ["assets"]

gulp.task "build", ["coffee-production", "jade-production", "stylus-production", "assets-production"]
gulp.task "default", ["coffee", "jade", "stylus", "assets", "watch", "server"]
