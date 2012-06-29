
module.exports = Flame.RootView.extend

  classNames: 'rootView'
  
  childViews: 'controlView arrangeHeaderView arrangeView'.w()

  layoutManager: Flame.VerticalStackLayoutManager.create
    topMargin: 0
    spacing: 0
    bottomMargin: 0

  controlView: require './control_view'

  arrangeHeaderView: require './arrange_header_view'

  arrangeView: require './arrange_view'