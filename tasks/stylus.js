/*
 * stylus task for grunt
 * Copyright (c) 2012 Greg Smith
 * This work is public domain.
 */

module.exports = function(grunt) {

  var nib = require("nib");
  var stylus = require("stylus");

  var path = require('path');

  grunt.registerMultiTask("stylus", "Compile Stylus files.", function() {
    var dest = this.file.dest;
    var files = grunt.file.expandFiles(this.file.src);
    files.forEach(function(fileName) {
      var str = grunt.file.read(fileName);
      grunt.log.writeln(fileName);
      var newFileName = fileName.match(/(\w+).styl/)[1] + ".css";
      var newFilePath = dest + "/" + newFileName;
      var compiler = stylus(str)
                      .include(path.dirname(fileName))
                      .use(nib());

      compiler.render(function(err, css){
        if (err) {
          grunt.fail.warn(err.message);
        }
        else {
          grunt.file.write(newFilePath, css);
          grunt.log.writeln("File \"" + newFilePath + "\" created.");
        }
      });
    });
  });

};