NS = require 'app'

module.exports = NS.ControlView = Em.View.extend

  templateName: require 'views/templates/control'

  init: ->
    @_super()