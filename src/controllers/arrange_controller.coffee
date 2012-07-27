
module.exports = Em.Controller.extend

  scale: 1

  zoomIn: ->
    @set 'scale', @get('scale')*1.5
  zoomOut: ->
    @set 'scale', @get('scale')/1.5