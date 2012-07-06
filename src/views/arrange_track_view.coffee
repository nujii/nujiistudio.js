App = require 'app'

module.exports = Flame.ListItemView.extend

  classNames: 'arrange-track'

  handlebars:
    """
    <div class="track-color-bar">
        <a class="caret" data-toggle="collapse" data-target="#test"></a>
    </div>
    
    <div class="arrange-track-controls">
      {{log this}}
      <div class="input-append track-controls">
        <input class="track-title" size="8" type="text"
         {{bindAttr value="name"}} /><button
         {{bindAttr class=":active :btn"}}>
            <span class="icon-play-circle"></span></button><button class="btn">
            <span class="icon-volume-up"></span>
          </button>
      </div>

      <div class="btn-group audio-controls">
        <button class="btn">
          <span class="icon-headphones"></span>
        </button>
        <button class="btn">
          <span class="icon-volume-off"></span>
        </button>
      </div>

      <button class="btn btn-small lock-button">
        <span class="icon-lock"></span>
      </button>
    </div>
    """