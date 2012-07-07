/*jshint evil:true*/

if (typeof document !== "undefined") {
  (function() {
    minispade = {
      root: null,
      modules: {},
      loaded: {},

      globalEval: function(data) {
        if ( data ) {
          // We use execScript on Internet Explorer
          // We use an anonymous function so that context is window
          // rather than jQuery in Firefox
          return ( window.execScript || function( data ) {
            return window[ "eval" ].call( window, data );
          } )( data );
        }
      },

      require: function(name) {
        var loaded = minispade.loaded[name];
        var mod = minispade.modules[name];

        if (!loaded) {
          if (mod) {

            var module = {exports:undefined};

            if (typeof mod === "string") {
              mod = minispade.globalEval(mod);
            }

            mod(module.exports, minispade.require, module);

            minispade.loaded[name] = module.exports;
            loaded = module.exports;
            
          } else {
            if (minispade.root && name.substr(0,minispade.root.length) !== minispade.root) {
              return minispade.require(minispade.root+name);
            } else {
              throw "The module '" + name + "' could not be found";
            }
          }
        }

        return loaded;
      },

      requireAll: function(regex) {
        for (var module in minispade.modules) {
          if (!minispade.modules.hasOwnProperty(module)) { continue; }
          if (regex && !regex.test(module)) { continue; }
          minispade.require(module);
        }
      },

      register: function(name, callback) {
        minispade.modules[name] = callback;
      }
    };

    window.require = minispade.require;
  })();
}