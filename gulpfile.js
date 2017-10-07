'use strict';

var gulp = require('gulp');  
var mocha = require('gulp-mocha');
var babel = require('babel-register');

gulp.task('test', function (cb) {
  gulp.src(['test/**/*.test.js'])
    .pipe(mocha({
      compilers: babel,
      reporter: 'spec',
      ui: 'bdd',
      timeout: 5000,
    }))
    .on('end', function () {
      cb();
    });
});
