/**
 * cssmin tasks
 * sqwish: https://github.com/ded/sqwish
 */
module.exports = function(grunt){
  
  var log = grunt.log;

  function handleResult(from, dest, err, stdout, code, done) {
    if(err){
      grunt.helper('growl', 'SQWISH GOT ERROR', stdout);
      log.writeln(from + ': failed to compile to ' + dest + '.');
      log.writeln(stdout);
      done(false);
    }else{
      log.writeln(from + ': compiled to ' + dest + '.');
      done(true);
    }
  }

  grunt.registerHelper('cssmin', function(src, dest, done) {
    var files = grunt.file.expandFiles(src);
    var args = {
      cmd: 'sqwish',
      args: [ files, '-o', dest ]
    };
    grunt.helper('exec', args, function(err, stdout, code){
      handleResult(files, dest, err, stdout, code, done);
    });
    return true;
  });

  grunt.registerMultiTask('cssmin', 'minify css by sqwish', function() {
    var done = this.async();
    var src = this.file.src;
    var dest = this.file.dest;
    grunt.helper('cssmin', src, dest, done);
    return true;
  });

};