App = require 'app'

module.exports = Flame.VerticalSplitView.extend

  layout:
    height: 27
    width: '100%'

  leftWidth: 250
  minLeftWidth: 250

  leftView: Flame.View.extend

    classNames: 'arrange-controls'

    template: Em.TEMPLATES[require 'templates/arrange-track-header']

  rightView: Flame.VerticalSplitView.extend

    layout:
      height: 27
      width: '100%'

    leftWidth: 0

    leftView: Flame.View.extend

      classNames: 'arrange-pluginheader'

      handlebars: 
        """
        <h4 class="title">Plugins</h4>
        """

    rightView: Flame.View.extend

      classNames: 'arrange-timeline'

      handlebars: 
        """
        """
