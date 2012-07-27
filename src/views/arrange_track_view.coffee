App = require 'app'

module.exports = Flame.ListItemView.extend

  classNames: 'arrange-track'

  templateContext: ((key, value) ->
    this.get('content')
  ).property('content').cacheable()

  toggleArm: ()->
    track = this.get 'content'
    #@get('target').toggleArm track
    @get('target').addTestRegion track

  toggleLock: ()->
    track = this.get 'content'
    @get('target').toggleLock track

  targetBinding: '^controller'

  handlebars:
    """
    <div class="track-color-bar">
        <a class="caret" data-toggle="collapse" data-target="#test"></a>
    </div>
    <div class="arrange-track-controls">
      <div class="input-append track-controls">
        {{view App.ArrangeTrackTextFieldView
               isEditableBinding="isEditable"
               valueBinding="title"
               placeholder="Untitled Track"}}

        <span class="track-button-group">
          <button {{bindAttr class="isArmed:active :btn"}} {{action toggleArm}}>
            <span class="icon-play-circle"></span></button><button class="btn">
            <span class="icon-volume-up"></span>
          </button>
        </span>
      </div>

      <div class="btn-group audio-controls">
        <button class="btn">
          <span class="icon-headphones"></span>
        </button>
        <button class="btn">
          <span class="icon-volume-off"></span>
        </button>
      </div>

      <button {{bindAttr class="isLocked:active :btn :btn-small :lock-button"}}
          {{action toggleLock}}>
        <span class="icon-lock"></span>
      </button>
    </div>
    """