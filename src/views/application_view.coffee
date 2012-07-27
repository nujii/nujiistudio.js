
module.exports = Flame.RootView.extend

  classNames: 'rootView'
  
  childViews: 'controlView globalView arrangeHeaderView arrangeView'.w()

  layoutManager: Flame.VerticalStackLayoutManager.create
    topMargin: 0
    spacing: 0
    bottomMargin: 0

  controlView: require 'views/control_view'

  globalView: require 'views/global_view'

  arrangeHeaderView: require 'views/arrange_header_view'

  arrangeView: require 'views/arrange_view'