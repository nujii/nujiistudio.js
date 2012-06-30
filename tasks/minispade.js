module.exports = function(grunt) {

  var path = require('path');

  // ==========================================================================
  // TASKS
  // ==========================================================================

  grunt.registerMultiTask('minispade', 'Minispade files.', function() {
    var files = grunt.file.expandFiles(this.file.src);
    // Concat specified files.
    var src = grunt.helper('minispade', files, this.data.root||process.cwd());
    grunt.file.write(this.file.dest, src);

    // Fail task if errors were logged.
    if (this.errorCount) { return false; }

    // Otherwise, print a success message.
    grunt.log.writeln('File "' + this.file.dest + '" created.');
  });

  // ==========================================================================
  // HELPERS
  // ==========================================================================

  // Concat source files and/or directives.
  grunt.registerHelper('minispade', function(files, root) {
    return files ? files.map(function(filepath) {
      var code = grunt.task.directive(filepath, grunt.file.read),
          id = '',
          ret = '';

      id = path.relative(path.resolve(root), path.resolve(filepath)).replace('.js','');

      code = JSON.stringify("(function(){return function(exports, require, module) { " + code + "}}).call(this); //@ sourceURL="+id+".js");
      ret += "minispade.register('"+id+"',"+code+");";
      return ret;

    }).join(grunt.utils.normalizelf('\n')) : '';
  });

};