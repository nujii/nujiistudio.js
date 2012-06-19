App = require 'app'

module.exports = App.ArrangeTrackView = Em.View.extend

  templateName: require 'views/templates/arrange-track'

  init: ->
    @_super()

  setVolume: (e) ->
    console.log @bindingContext
    @bindingContext.set 'volume', e.target.value