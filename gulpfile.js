var gulp = require('gulp');
var sass = require('gulp-sass');
var ts = require('gulp-typescript');
var minifyCSS = require('gulp-csso');

gulp.task('css', function(){
    return gulp.src('lib/assets/scss/*.scss')
        .pipe(sass())
        .pipe(minifyCSS())
        .pipe(gulp.dest('public/css'));
});

gulp.task('js', function () {
    return gulp.src('lib/assets/ts/*.ts')
        .pipe(ts({
            noImplicitAny: true,
            outFile: 'script.js'
        }))
        .pipe(gulp.dest('public/js'));
});

gulp.task('default', ['css', 'js']);
