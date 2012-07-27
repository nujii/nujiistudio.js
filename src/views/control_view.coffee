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

    templateContext: ((key, value) ->
      App.transport
    ).property()

    handlebars:
      """
      <div class="btn-group">
        <button {{bindAttr class="isRecording:disabled
                                  :btn"}}
                {{action beginning target="App.transport"}}>
          <span class="icon-fast-backward"></span>
        </button>
        <button {{bindAttr class="isRewinding:active
                                  isRecording:disabled
                                  :btn"}}
                {{action rewind target="App.transport"}}>
          <span class="icon-backward"></span>
        </button>
        <button {{bindAttr class="isPlaying:active :btn"}}
                {{action togglePlay target="App.transport"}}>
          <span class="icon-play"></span>
        </button>
        <button {{bindAttr class="isRecording:active :btn"}}
                {{action record target="App.transport"}}>
          <span class="icon-play-circle"></span>
        </button>
        <button {{bindAttr class="isFastForwarding:active
                                  isRecording:disabled
                                  :btn"}}
                {{action fastforward target="App.transport"}}>
          <span class="icon-forward"></span>
        </button>
        <button {{bindAttr class=":btn"}}
                {{action stop target="App.transport"}}>
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
        <button class="btn"
                {{action zoomOut target="App.router.arrangeController"}}>
          <span class="icon-zoom-out"></span>
        </button>
        <button class="btn"
                {{action zoomIn target="App.router.arrangeController"}}>
          <span class="icon-zoom-in"></span>
        </button>
        <button class="btn">
          <span class="icon-headphones"></span>
        </button>
        <button class="btn">
          <span class="icon-cog"></span>
        </button>
      </div>
      """