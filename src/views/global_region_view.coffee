
util = require 'lib/util'

module.exports = Flame.View.extend

  classNames: ['test-region']

  layout: ((key, value) ->
    region = @get('bindingContext')
    projectLength = App.project.get 'length'
    width = region.get('length')/projectLength*100
    left = region.get('position')/projectLength*100
    layout =
      left: left+'%'
      top: 0
      width: width+'%'
      height: '6'
    layout
  ).property('bindingContext.position', 'bindingContext.length')

  templateContext: (()->
    @get('bindingContext')
  ).property 'bindingContext', 'bindingContext.position'

  didInsertElement: ()->
    region = @get('templateContext')
    id = @get('elementId')
    $elem = $('#'+id)

    # For some reason the Flame.js layout doesn't observe changes.
    # We'll do this until we figure out a better way.
    updatePos = ()->
      projectLength = App.project.get 'length'
      width = region.get('length')/projectLength*100
      left = region.get('position')/projectLength*100
      $elem.css 'width', width+'%'
      $elem.css 'left', left+'%'

    region.addObserver 'position', @, ->
      updatePos()

    App.project.addObserver 'length', @, ->
      updatePos()