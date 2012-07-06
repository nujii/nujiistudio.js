
module.exports = Flame.RootView.extend

  classNames: 'rootView'
  
  childViews: 'controlView arrangeHeaderView arrangeView'.w()

  layoutManager: Flame.VerticalStackLayoutManager.create
    topMargin: 0
    spacing: 0
    bottomMargin: 0

  controlView: require 'views/control_view'

  arrangeHeaderView: require 'views/arrange_header_view'

  arrangeView: require 'views/arrange_view'