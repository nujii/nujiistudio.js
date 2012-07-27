

module.exports = Flame.ListView.extend

  classNames: 'arrange-sidebar arrange-tracklist'
  
  contentBinding: 'App.router.tracksController'
  controllerBinding: 'App.router.tracksController'

  reorderDelegate: (()->
    @get 'controller'
  ).property 'controller'

  itemViewClass: require 'views/arrange_track_view'
  allowSelection: true
  allowReordering: true

  didInsertElement: ()->
    $(@$()).css('margin-bottom', require('lib/util').scrollBarWidth())