fs   = require 'fs'
path = require 'path'

# See docs at http://brunch.readthedocs.org/en/latest/config.html.

exports.config = 

  files:
    javascripts:
      defaultExtension: 'coffee',
      joinTo: 
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^vendor/

      order: 
        before: [
          'vendor/scripts/console-helper.js',
          'vendor/scripts/jquery-1.7.2.js',
          'vendor/scripts/handlebars-1.0.0.beta.6.js',
          'vendor/scripts/ember-0.9.8.1.js',
          'vendor/scripts/bootstrap.js'
          ]

    stylesheets:
      defaultExtension: 'styl'
      joinTo: 'stylesheets/app.css'
      order:
        before: ['vendor/styles/bootstrap.css']

    templates:
      defaultExtension: 'hbs'
      joinTo: 'javascripts/app.js' : /^app/

  generators:
    model: (name)->
      fs.readFileSync(path.join(__dirname, 'generators', 'model.coffee')).toString().replace(/\#{name}/g, name)
    view: (name)->
      fs.readFileSync(path.join(__dirname, 'generators', 'view.coffee')).toString().replace(/\#{name}/g, name)
    controller: (name)->
      fs.readFileSync(path.join(__dirname, 'generators', 'controller.coffee')).toString().replace(/\#{name}/g, name)