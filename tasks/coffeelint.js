/**
 * coffeelint tasks
 * coffeelint: http://www.coffeelint.org/
 */
module.exports = function(grunt){
  
  var log = grunt.log;

  function handleResult(dir, err, stdout, code, done) {
    var trimed = grunt.helper('trimcolors', stdout);
    var hasError = trimed.indexOf(' 0 errors') === -1;
    if(hasError){
      grunt.helper('growl', 'COFFEELINT FOUND ERROR', trimed);
      log.write(stdout);
      done(false);
    }else{
      log.writeln('coffeelint found no error');
      done(true);
    }
  }

  grunt.registerHelper('coffeelint', function(dir, done) {
    var args = {
      cmd: 'coffeelint',
      args: [ '-r', dir ]
    };
    grunt.helper('exec', args, function(err, stdout, code){
      handleResult(dir, err, stdout, code, done);
    });
    return true;
  });

  grunt.registerMultiTask('coffeelint', 'coffeelint', function() {
    var done = this.async();
    var dir = this.data.dir;

    grunt.helper('coffeelint', dir, done);
    return true;
  });

};
