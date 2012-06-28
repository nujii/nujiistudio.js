App = require 'app'

module.exports = App.ArrangeTrackView = Em.View.extend

  templateName: require 'templates/arrange-track'

  title: 'Audio Track'

  setVolume: (e) ->
    console.log @bindingContext
    @bindingContext.set 'volume', e.target.value