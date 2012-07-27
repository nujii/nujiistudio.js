
GlobalRegionView = require 'views/global_region_view'

util = require 'lib/util'

module.exports = GlobalRegionView.extend Flame.ActionSupport,

  classNames: ['test-region']


  layout: ((key, value) ->
    scale = App.router.arrangeController.get 'scale'
    region = @get('bindingContext')
    layout =
      left: util.secToPx region.get('position'), scale
      top: 2
      width: util.secToPx region.get('length'), scale
      height: '95%'
    layout
  ).property('bindingContext.position', 'bindingContext.length')

  attributeBindings: ['isDraggable:draggable']

  acceptsKeyResponder: false

  isDraggable: 'true'

  didInsertElement: ()->
    region = @get('templateContext')
    id = @get('elementId')
    $elem = $('#'+id)

    # For some reason the Flame.js layout doesn't observe changes.
    # We'll do this until we figure out a better way.
    updatePos = ()->
      pos = region.get 'position'
      scale = App.router.arrangeController.get 'scale'
      $elem.css 'left', util.secToPx pos, scale

    region.addObserver 'position', @, ->
      updatePos()

    App.router.arrangeController.addObserver 'scale', @, ->
      length = region.get('length')
      scale = App.router.arrangeController.get 'scale'
      $elem.css 'width', util.secToPx length, scale
      updatePos()

    $elem.on 'dragstart', (evt)->
      evt.dataTransfer.effectAllowed = 'move'
      origX = evt.originalEvent.clientX
      # TODO make this more meaningful
      evt.dataTransfer.setData 'text', region.get('id')
      evt.dataTransfer.setData 'pos', origX

  mouseDown: ()->
    Flame.ALLOW_BROWSER_DEFAULT_HANDLING

  mouseMove: ()->
    Flame.ALLOW_BROWSER_DEFAULT_HANDLING

  mouseUp: ()->
    Flame.ALLOW_BROWSER_DEFAULT_HANDLING

  handlebars:
    """

    """