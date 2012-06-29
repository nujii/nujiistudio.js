

module.exports = Flame.ListView.extend

  classNames: 'arrange-sidebar arrange-tracklist'

  contentBinding: 'App.router.tracksController.tracks'

  itemViewClass: require './arrange_track_view'
  allowSelection: false
  allowReordering: false

  didInsertElement: ()->
    $(@$()).css('margin-bottom', require('./../lib/util').scrollBarWidth())