App = require 'app'

module.exports = App.ArrangeTrackView = Em.View.extend

  templateName: require 'templates/arrange-track'

  setVolume: (e) ->
    console.log @bindingContext
    @bindingContext.set 'volume', e.target.value