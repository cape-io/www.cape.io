path = require 'path'
#fs = require 'fs-extra'
exec = require('child_process').exec

gulp = require 'gulp'
r = require 'request'

browserSync = require 'browser-sync'

browserify = require 'browserify'
exorcist = require 'exorcist'
watchify = require 'watchify'
#bd = require 'browserify-data'

buffer = require 'vinyl-buffer'
source = require 'vinyl-source-stream'
transform = require 'vinyl-transform'

less = require 'gulp-less'
gutil = require 'gulp-util'
clean = require 'gulp-clean'
#zopfli = require 'gulp-zopfli'
rename = require 'gulp-rename'
uglify = require 'gulp-uglify'
gdata = require 'gulp-data'
debug = require 'gulp-debug'
deploy = require 'gulp-gh-pages'
runSequence = require 'run-sequence'
markdown = require 'gulp-markdown-to-json'
yaml = require 'gulp-yaml'
sourcemaps = require 'gulp-sourcemaps'

serverData = require './serverData'
content = require './content'

# Default gulp tasks watches files for changes
gulp.task "default", ['browser-sync'], ->
  #gulp.watch './app/**/*.*', ['templates', browserSync.reload]
  gulp.watch "styles/*.less", ["styles", browserSync.reload]
  gulp.watch 'static/**', ['static', browserSync.reload]
  gulp.watch './content/**/*.md', ['content', browserSync.reload]
  gulp.watch './content/**/*.yaml', ['data', browserSync.reload]
  return

# For development.
gulp.task "browser-sync", ['compile-watch', 'styles', 'static'], ->
  browserSync
    server:
      baseDir: 'public'
    open: 'external'
    host: 'l.cape.io'
    logConnections: true
    injectChanges: false
    #logLevel: 'debug'
  return

# This generate js app file.
gulp.task 'compile', ->
  browserified = transform (filename) ->
    b = browserify {debug: true, extensions: ['.cjsx', '.coffee']}
    b.add filename
    #b.transform 'coffee-reactify'
    b.bundle()
  gulp.src 'app/app.cjsx'
    .pipe browserified
    # Extract the map.
    .pipe transform(-> exorcist('./public/assets/app.js.map'))
    # Shrink the codebase.
    .pipe uglify()
    # Rename the file.
    .pipe rename('app.js')
    .pipe gulp.dest('./public/assets')

# WATCHIFY
opts = watchify.args
opts.extensions = ['.coffee', '.cjsx']
opts.debug = true
w = watchify browserify('./app/app.cjsx', opts)

bundle = () ->
  runSequence 'templates'
  w.bundle()
    .on 'error', gutil.log.bind gutil, 'Browserify Error'
    .pipe source('app.js')
      .pipe buffer()
      .pipe(sourcemaps.init({loadMaps: true}))
      .pipe(sourcemaps.write('./'))
    .pipe gulp.dest('./public/assets')
    .pipe browserSync.reload({stream:true})
w.on 'update', bundle

gulp.task 'compile-watch', ['serverData'], bundle


# Convert yaml files from the content dir to json files.
gulp.task 'data', ->
  gulp.src './content/**/*.yaml'
    .pipe yaml()
    .pipe gulp.dest('./app/data/')

# Convert markdown files from content dir to json files.
# gulp.task 'content', ->
#   content()
gulp.task 'content', ->
  gulp.src './content/**/*.md'
    .pipe markdown()
    .pipe gulp.dest('./app/data/')

gulp.task 'serverData', ['data', 'content'], (cb) ->
  serverData cb

# Compile the static html files.
gulp.task 'templates', (cb) ->
  # Calling an external script for this.
  exec 'coffee ./scripts/renderMarkup.coffee', (err, stdout, stderr) ->
    if stdout
      console.log stdout
    if stderr
      console.log stderr
    cb err

# Process LESS to CSS.
gulp.task 'styles', ->
  gulp.src(["styles/app.less", 'styles/print.less', 'styles/iefix.less'])
    .pipe less()
    .pipe gulp.dest("./public/assets")

# Copy static files.
gulp.task 'static', ->
  gulp.src('./static/**')
    .pipe gulp.dest('./public/')

# - - - - prod - - - -

gulp.task 'prod', ['prod_clean'], (cb) ->
  runSequence ['static', 'serverData'], ['templates', 'compile', 'styles'], cb

# Remove contents from public directory.
gulp.task 'prod_clean', ->
  gulp.src('./public', read: false)
    .pipe(clean())


gulp.task 'deploy', ['prod'], ->
  gulp.src './public/**/*'
    .pipe deploy cacheDir: './tmp'

# gulp.task 'templatesProd', ->
#   exec('coffee gulp/compileProd.coffee')

gulp.task 'set_sha', (cb) ->
  r_ops =
    uri: 'https://api.github.com/repos/cape-io/mica.ezle.io/branches/master'
    json: true
    headers:
      'user-agent': 'request.js'
  r r_ops, (err, response, body) ->
    if err then throw err
    global.sha = body.commit.sha
    fs.outputJsonSync 'app/data/commit.json', body.commit
    cb()
  return

# Remove contents from prod directory.
gulp.task 'prod_clean', ->
  gulp.src('./prod', read: false)
    .pipe(clean())

gulp.task 'prod_static', ->
  gulp.src('./static/**')
    .pipe gulp.dest('./prod/')

gulp.task 'cssProd', ->
  runSequence 'set_sha', ['copy_css', 'templatesProd']
  return

gulp.task 'copy_css', ['styles'], ->
  gulp.src('./dev/app.css')
    .pipe(rename(global.sha+'.css'))
    .pipe(gulp.dest('./prod'))
  gulp.src('./dev/print.css')
    .pipe(gulp.dest('./prod'))

gulp.task 'compress', ->
  gulp.src("./prod/*.{js,css,html,json}")
    .pipe(zopfli())
    .pipe(gulp.dest("./prod"))
