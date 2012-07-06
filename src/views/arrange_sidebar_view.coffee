

module.exports = Flame.ListView.extend

  classNames: 'arrange-sidebar arrange-tracklist'

  contentBinding: 'App.router.tracksController.tracks'

  itemViewClass: require 'views/arrange_track_view'
  allowSelection: true
  allowReordering: true

  didInsertElement: ()->
    $(@$()).css('margin-bottom', require('lib/util').scrollBarWidth())