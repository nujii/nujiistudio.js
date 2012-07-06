App = require 'app'

module.exports = Flame.ListView.extend

  classNames: 'arrange-content'

  contentBinding: 'App.router.tracksController.tracks'

  itemViewClass: require 'views/arrange_track_content_view'
  allowSelection: false
  allowReordering: false