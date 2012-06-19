App = require 'app'

module.exports = App.Views.#{name} = Em.View.extend

  templateName: require 'views/templates/#{name}'

  init: ->
    @_super()