App = require 'app'

util = require 'lib/util'


module.exports = Flame.ListView.extend

  classNames: 'global-content'

  contentBinding: 'App.router.tracksController'

  childViews: 'playheadView'.w()

  layout:
    height: 50
    left: 0
    right: 0

  itemViewClass: Flame.ListItemView.extend

    classNames: 'global-track'

    templateContext: ((key, value) ->
      @get('content')
    ).property('content').cacheable()

    acceptsKeyResponder: true

    handlebars:
      """
      {{#each regions}}
        {{view App.GlobalRegionView}}
      {{/each}}
      """

  allowSelection: false
  allowReordering: false

  mouseDown: ()->
    Flame.ALLOW_BROWSER_DEFAULT_HANDLING

  mouseUp: ()->
    Flame.ALLOW_BROWSER_DEFAULT_HANDLING

  playheadView: Flame.View.extend
    layout:
      top: 0
      bottom: 0
      width: 3

    classNames: 'playhead'

    didInsertElement: ()->
      layout = @get 'layout'
      id = @get('elementId')
      $elem = $('#'+id)

      updateCursor = (location)->
        left = location/App.project.get('length')*100
        $elem.css 'left', left+'%'

      updateCursor()

      # For some reason the Flame.js layout doesn't observe changes.
      # We'll do this until we figure out a better way.

      App.transport.addObserver 'playhead', $elem, ()->
        updateCursor App.transport.get 'playhead'