App = require 'app'

module.exports = Flame.VerticalSplitView.extend

  layout:
    height: 27
    width: '100%'

  leftWidth: 250
  minLeftWidth: 250

  leftView: Flame.View.extend

    classNames: 'arrange-controls'

    handlebars:
      """
      <div class="buttons">
      <button type="button" class="btn btn-mini">
        <span class="icon-align-justify icon-white"></span>
      </button>
      <button type="button" class="btn btn-mini">
        <span class="icon-plus icon-white"></span>
      </button>
    </div>
    <h4 class="title">Tracks</h4>
    <div class="btn-group dropdown">
      <button class="btn btn-mini dropdown-toggle" data-toggle="dropdown">
        Plugins<span class="caret"></span>
      </button>
      <ul class="dropdown-menu">
        <li><a href="#">Reverb</a></li>
        <li><a href="#">Compressor</a></li>
        <li><a href="#">Something Cool</a></li>
      </ul>
    </div>
      """

  rightView: Flame.VerticalSplitView.extend

    layout:
      height: 27
      width: '100%'

    leftWidth: 200

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
