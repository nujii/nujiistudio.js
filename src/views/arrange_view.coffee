App = require 'app'

module.exports = Flame.VerticalSplitView.extend

  classNames: 'scrollable'

  leftWidth: 250

  allowResizing: false
  dividerThickness: 0

  leftView: require 'views/arrange_sidebar_view'

  controller: require 'controllers/tracks_controller'

  rightView: Flame.VerticalSplitView.extend
    layout:
      width: '100%'

    leftWidth: 0
    allowResizing: false
    dividerThickness: 0

    leftView: Flame.View.extend

      classNames: 'arrange-pluginlist'

      handlebars:
        """
        """

    rightView: require 'views/arrange_content_view'

  didInsertElement: ()->
    that = @
    sidebar = $(@$('.arrange-sidebar')[0])
    content = $(@$('.arrange-content')[0])
    @watchScroll content, sidebar, true
    @watchScroll sidebar, content

  watchScroll: (firstElem, secondElem, moveHorizontal)->
    scrollScale = 10
    firstElem.on 'mousewheel', (e)->
      if e.originalEvent.wheelDeltaY
        e.preventDefault()
        top = firstElem.scrollTop()
        yPos = top-e.originalEvent.wheelDeltaY/scrollScale
        secondElem.scrollTop yPos
        firstElem.scrollTop yPos
        if moveHorizontal
          xPos = firstElem.scrollLeft()-e.originalEvent.wheelDeltaX/scrollScale
          firstElem.scrollLeft xPos
            

    firstElem.scroll (e)->
      pos = firstElem.scrollTop()
      if pos != secondElem.scrollTop()
        e.preventDefault()
        secondElem.scrollTop pos
        firstElem.scrollTop pos
