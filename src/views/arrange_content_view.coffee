App = require 'app'
util = require 'lib/util'

module.exports = Flame.View.extend
  childViews: 'listView'.w()

  classNames: 'arrange-content-wrapper'

  listView: Flame.ListView.extend

    classNames: 'arrange-content'

    contentBinding: 'App.router.tracksController'

    childViews: 'playheadView'.w()

    itemViewClass: require 'views/arrange_track_content_view'
    allowSelection: false
    allowReordering: false

    didInsertElement: ()->
      id = @get('elementId')
      $elem = $('#'+id)

      updateWidth = (length)->
        scale = App.router.arrangeController.get 'scale'
        $elem.css 'width', util.secToPx length+1000, scale

      updateWidth()

      App.project.addObserver 'length', $elem, ->
        updateWidth App.project.get 'length'

      App.router.arrangeController.addObserver 'scale', $elem, ->
        updateWidth App.project.get 'length'


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
          scale = App.router.arrangeController.get 'scale'
          $elem.css 'left', util.secToPx location, scale

        updateCursor()

        # For some reason the Flame.js layout doesn't observe changes.
        # We'll do this until we figure out a better way.

        App.transport.addObserver 'playhead', $elem, ()->
          updateCursor App.transport.get 'playhead'

        App.router.arrangeController.addObserver 'scale', $elem, ->
          updateCursor App.transport.get 'playhead'