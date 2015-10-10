gulp = require "gulp"
sass = require "gulp-sass"
zip = require "gulp-zip"
pkg = require "./package"

paths =
  dest: "build/946procon"

gulp.task "scss", ->
  gulp.src "src/scss/style.scss"
    .pipe sass
      outputStyle: "compressed"
      includePaths: [
        "bower_components/normalize-scss"
        "bower_components/bourbon/dist"
        "bower_components/neat/app/assets/stylesheets"
      ]
    .pipe gulp.dest paths.dest

gulp.task "license", ->
  gulp.src "bower_components/normalize-scss/LICENSE.md"
    .pipe gulp.dest "#{ paths.dest }/licenses/normalize-scss"
  gulp.src "bower_components/bourbon/LICENSE"
    .pipe gulp.dest "#{ paths.dest }/licenses/bourbon"

gulp.task "images", ->
  gulp.src "src/images/**/*"
    .pipe gulp.dest "#{ paths.dest }/images"

gulp.task "archive", ["scss", "license", "images"], ->
  gulp.src "build/**/*"
    .pipe zip "946procon-#{ pkg.version }.zip"
    .pipe gulp.dest "releases"

gulp.task "watch", ->
  gulp.watch "src/scss/**/*.scss", ["scss"]
  gulp.watch "src/images/**/*", ["images"]

gulp.task "default", ["archive"]
