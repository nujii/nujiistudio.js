/*
 * Is injected into the spec runner file
 
 * Copyright (c) 2012 Kelly Miyashiro
 * Copyright (c) 2012 "Cowboy" Ben Alman
 * Licensed under the MIT license.
 * http://benalman.com/about/license/
 */

/*global mocha:true, alert:true*/

// Send messages to the parent phantom.js process via alert! Good times!!
function sendMessage() {
  var args = [].slice.call(arguments);
  alert(JSON.stringify(args));
}

mocha.reporters.Grunt = function Grunt(runner){
  mocha.reporters.HTML.call(this, runner);
  
  /**
   * Listen on `event` with callback `fn`.
   */

  // function on(el, event, fn) {
  //   if (el.addEventListener) {
  //   el.addEventListener(event, fn, false);
  //   } else {
  //   el.attachEvent('on' + event, fn);
  //   }
  // }
  
  runner.on('test', function(test) {
    sendMessage('testStart', test.title);
  });
  
  runner.on('test end', function(test) {
    sendMessage('testDone', test.title, test.state);
  });
  
  runner.on('suite', function(suite) {
    sendMessage('suiteStart', suite.title);
  });
  
  runner.on('suite end', function(suite) {
    if (suite.root) return;
    sendMessage('suiteDone', suite.title);
  });
  
  runner.on('fail', function(test, err) {
    sendMessage('testFail', test.title, err);
  });
  
  runner.on('end', function() {
    var output = {
      failed  : this.failures,
      passed  : this.total - this.failures,
      total   : this.total
    };
    
    sendMessage('done', output.failed,output.passed, output.total);
  });
};

// override default
if(window.PHANTOMJS){
  (function(){
    var suite = new mocha.Suite('', new mocha.Context);
    var Reporter = mocha.reporters.Grunt;
    var utils = mocha.utils;

    function parse(qs) {
        return utils.reduce(qs.replace('?', '').split('&'), function(obj, pair){
            var i = pair.indexOf('=')
              , key = pair.slice(0, i)
              , val = pair.slice(++i);

            obj[key] = decodeURIComponent(val);
            return obj;
          }, {});
      }

    mocha.setup = function(ui){
        ui = mocha.interfaces[ui];
        if (!ui) throw new Error('invalid mocha interface "' + ui + '"');
        ui(suite);
        suite.emit('pre-require', window);
      };

    mocha.run = function(){
      suite.emit('run');
      var runner = new mocha.Runner(suite);
      var reporter = new Reporter(runner);
      var query = parse(window.location.search || "");
      if (query.grep) runner.grep(new RegExp(query.grep));
      runner.on('end', function(){
        $('code').each(function(){
          $(this).html(highlight($(this).text()));
        });
      });
      return runner.run();
    };
  })();
}
