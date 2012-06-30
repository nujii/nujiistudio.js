App = require 'app'

module.exports = Flame.View.extend
  classNames: 'control'

  childViews: 'transportView displayView settingsView'.w()

  layout:
    height: 60
    width: '100%'

  transportView: Flame.View.extend
    layout:
      height: 27
      left: 15
      top: 15

    handlebars:
      """
      <div class="btn-group">
        <button class="btn">
          <span class="icon-fast-backward"></span>
        </button>
        <button class="btn">
          <span class="icon-backward"></span>
        </button>
        <button class="btn">
          <span class="icon-play"></span>
        </button>
        <button class="btn">
          <span class="icon-play-circle"></span>
        </button>
        <button class="btn">
          <span class="icon-forward"></span>
        </button>
        <button class="btn">
          <span class="icon-stop"></span>
        </button>
      </div>
      """

  displayView: Flame.View.extend

    classNames: 'display'

    layout:
      width: 212
      height: 45
      top: 8
      left: '50%'

    handlebars:
      """
      <div class="time-display-background"></div>
      <div class="time-display">
        <h2>1:2:880{{timestamp}}</h2>
      </div>
      """

  settingsView: Flame.View.extend
    layout:
      height: 27
      right: 15
      top: 15

    handlebars:
      """
      <div class="btn-group">
        <button class="btn">
          <span class="icon-zoom-out"></span>
        </button>
        <button class="btn">
          <span class="icon-headphones"></span>
        </button>
        <button class="btn">
          <span class="icon-cog"></span>
        </button>
      </div>
      """