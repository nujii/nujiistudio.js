NS = require 'app'

module.exports = NS.ApplicationView = Em.View.extend

  templateName: require 'views/templates/application'

  init: ->
    @_super()