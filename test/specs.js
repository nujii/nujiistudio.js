minispade.register('test/app_test',"(function(){return function(exports, require, module) { // Generated by CoffeeScript 1.3.3\nvar App, should;\n\nApp = require('app');\n\nshould = require('chai').should();\n\nconsole.log(App);\n\ndescribe('App', function() {\n  it('should defined', function() {\n    return should.exist(App);\n  });\n  return it('should have a router', function() {\n    return should.exist(App.router);\n  });\n});\n}}).call(this); //@ sourceURL=test/app_test.js");
minispade.register('test/tests',"(function(){return function(exports, require, module) { // Generated by CoffeeScript 1.3.3\n\nrequire('test/app_test');\n}}).call(this); //@ sourceURL=test/tests.js");