App = require 'app'

util = require 'lib/util'

module.exports = Flame.ListItemView.extend

  classNames: 'track-content'

  templateContext: ((key, value) ->
    @get('content')
  ).property('content').cacheable()

  acceptsKeyResponder: true

  didInsertElement: ()->
    id = @get('elementId')
    $elem = @$()

    track = @get 'content'

    $elem.on 'dragover', (e)->
      e.preventDefault()
      false

    $elem.on 'drop', (e)->
      e.preventDefault()
      id = e.dataTransfer.getData 'text'
      origPos = parseInt e.dataTransfer.getData 'pos'
      region = App.Region.find id

      offset = e.originalEvent.clientX-origPos
      scale = App.router.arrangeController.get('scale')
      newPos = region.get('position')+util.pxToSec(offset, scale)
      newPos = 0 if newPos < 0
      region.set 'position', newPos

      # We also need to move the region to this track
      # if it's not already
      track.moveRegionToTrack region

      region.store.commit()
      false

  mouseDown: ()->
    Flame.ALLOW_BROWSER_DEFAULT_HANDLING

  mouseUp: ()->
    Flame.ALLOW_BROWSER_DEFAULT_HANDLING

  mouseMove: ()->
    Flame.ALLOW_BROWSER_DEFAULT_HANDLING

  handlebars:
    """
    {{#each regions}}
      {{view App.ArrangeRegionView}}
    {{/each}}
    """