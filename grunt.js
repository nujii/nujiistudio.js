module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    pkg: '<json:package.json>',
    meta: {
      banner: '/*!\n'+
        ' * <%= pkg.name %> - v<%= pkg.version %> - ' +
        '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
        '<%= pkg.homepage ? " * " + pkg.homepage + "\n" : "" %>' +
        ' * Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;\n' +
        ' * \n'+
        ' * Licensed under the Apache License, Version 2.0 (the "License");\n'+
        ' * you may not use this file except in compliance with the License.\n'+
        ' * You may obtain a copy of the License at\n'+
        ' * \n'+
        ' *   http://www.apache.org/licenses/LICENSE-2.0\n'+
        ' * \n'+
        ' * Unless required by applicable law or agreed to in writing, software\n'+
        ' * distributed under the License is distributed on an "AS IS" BASIS,\n'+
        ' * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\n'+
        ' * See the License for the specific language governing permissions and\n'+
        ' * limitations under the License.\n'+
        ' */'
    },

    // Javascript
    coffee: {
      app: {
        dir: 'src/',
        dest: 'tmp/javascripts'
      },
      test: {
        dir: 'test/specs',
        dest: 'tmp/test'
      }
    },
    coffeelint: {
      app: {
        dir: '<config:coffee.app.dir>'
      },
      test: {
        dir: '<config:coffee.test.dir>'
      }
    },

    // CSS
    stylus: {
      app: {
        src: ["stylesheets/**"],
        dest: "tmp/stylesheets/app"
      }
    },
    csslint: {
      app: {
        src: 'tmp/stylesheets/app/**',
        rules: {
          'important': false,
          'duplicate-properties': false,
          'compatible-vendor-prefixes': false,
          'adjoining-classes': false,
          'zero-units': false
        }
      }
    },
    less: {
      bootstrap: {
        src: 'vendor/stylesheets/bootstrap.less',
        dest: 'tmp/stylesheets/vendor/bootstrap.css'
      }
    },

    // Assets
    copy: {
      indexhtml: {
        from: 'assets/index.html',
        to: 'dist/'
      },
      images: {
        from: 'assets/images/*',
        to: 'dist/images/'
      },
      flamecss: {
        from: 'vendor/stylesheets/flame.css',
        to: 'tmp/stylesheets/vendor/'
      }
    },

    // Build
    minispade : {
      app: {
        src: 'tmp/javascripts/**',
        dest: 'tmp/<%= pkg.name %>.js',
        root: 'tmp/javascripts'
      },
      test: {
        src: 'tmp/test/**',
        dest: 'test/specs.js',
        root: 'tmp'
      }
    },
    concat: {
      css: {
        src: ['<banner:meta.banner>',
              'tmp/stylesheets/app/*'],
        dest: 'dist/stylesheets/<%= pkg.name %>.css'
      },
      js: {
        src: ['<banner:meta.banner>',
              'tmp/<%= pkg.name %>.js'],
        dest: 'dist/javascripts/<%= pkg.name %>.js'
      },
      vendor: {
        src: ['vendor/javascripts/console-helper.js',
              'vendor/javascripts/jquery-1.7.2.js',
              'vendor/javascripts/handlebars-1.0.0.beta.6.js',
              'vendor/javascripts/ember-latest.js',
              'vendor/javascripts/flame.js',
              'vendor/javascripts/bootstrap.js',
              'vendor/javascripts/minispade.js'],
        dest: 'dist/javascripts/vendor.js'
      },
      vendorcss: {
        src: ['tmp/stylesheets/vendor/flame.css',
              'tmp/stylesheets/vendor/bootstrap.css'],
        dest: 'dist/stylesheets/vendor.css'
      }
    },

    // Compression
    cssmin: {
      app: {
        src: '<config:concat.css.dest>',
        dest: 'dist/stylesheets/<%= pkg.name %>.min.css'
      },
      vendor: {
        src: '<config:concat.vendorcss.dest>',
        dest: 'dist/stylesheets/vendor.min.css'
      }
    },
    min: {
      app: {
        src: 'tmp/javascripts/*',
        dest: 'tmp/javascripts.min.js'
      },
      vendor: {
        src: '<config:concat.vendor.dest>',
        dest: 'dist/javascripts/vendor.min.js'
      }
    },

    // Development
    mocha: {
      index: 'test/nujiistudio-tests.html'
    },
    server: {
      port: 3333,
      base: 'dist'
    },
    reload: {
      port: 35729,
      liveReload: true
    },
    watch: {
      coffee: {
        files: 'src/**',
        tasks: 'app-js mocha'
      },
      stylus: {
        files: '<config:stylus.app.src>',
        tasks: 'app-css'
      },
      indexhtml: {
        files: 'assets/index.html',
        tasks: 'app-html'
      },
      images: {
        files: 'assets/images/*',
        tasks: 'app-images'
      },
      vendorjs: {
        files: 'vendor/javascripts/*',
        tasks: 'vendor-js mocha'
      },
      test: {
        files: 'test/specs/**',
        tasks: 'build-tests mocha'
      },
      dist: {
        files: 'dist/**',
        tasks: 'reload'
      }
    }
  });

  grunt.loadTasks('tasks');
  grunt.loadNpmTasks('grunt-css');
  grunt.loadNpmTasks('grunt-less');
  grunt.loadNpmTasks('grunt-mocha');
  grunt.loadNpmTasks('grunt-reload');

  // Build Tasks
  grunt.registerTask('app-js', 'coffeelint:app coffee:app minispade:app concat:js');
  grunt.registerTask('app-css', 'stylus:app concat:css csslint:app');
  grunt.registerTask('app-html', 'copy:indexhtml');
  grunt.registerTask('app-images', 'copy:images');
  grunt.registerTask('vendor-js', 'concat:vendor');
  grunt.registerTask('vendor-css', 'copy:flamecss less:bootstrap concat:vendorcss');
  grunt.registerTask('build-all', 'app-js app-css app-html app-images vendor-js vendor-css');

  // Tests
  grunt.registerTask('build-tests', 'coffeelint:test coffee:test minispade:test');
  grunt.registerTask('test', 'build-all build-tests mocha');

  // Main Tasks
  grunt.registerTask('dev', 'build-all build-tests server reload watch');
  grunt.registerTask('prod', 'build-all cssmin min');

  // Default task
  grunt.registerTask('default', 'prod');

};
