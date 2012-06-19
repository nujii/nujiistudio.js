App = require 'app'

module.exports = App.ArrangeView = Em.View.extend

  templateName: require 'views/templates/arrange'

  init: ->
    @_super()