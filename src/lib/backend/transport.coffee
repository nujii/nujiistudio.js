
module.exports = Transport = Em.Object.extend

  stateManager: Em.StateManager.create
    initialState: 'playback'
    states:
      playback: Em.State.create
        initialState: 'disabled'

        # States
        enabled: Em.State.create()
        disabled: Em.State.create()
        rewind: Em.State.create()
        fastforward: Em.State.create()
      record: Em.State.create
        initialState: 'enabled'

        # States
        enabled: Em.State.create()
        disabled: Em.State.create()

  isPlaying: (->
    stateName = @getPath 'stateManager.currentState.name'
    stateName in ['enabled', 'rewind', 'fastforward']
  ).property 'stateManager.currentState'

  isRewinding: (->
    stateName = @getPath 'stateManager.currentState.name'
    stateName == 'rewind'
  ).property 'stateManager.currentState'

  isFastForwarding: (->
    stateName = @getPath 'stateManager.currentState.name'
    stateName == 'fastforward'
  ).property 'stateManager.currentState'

  canSetPlayhead: (->
    not @get 'isRecording'
  ).property 'isRecording'

  isPaused: (->
    stateName = @getPath 'stateManager.currentState.name'
    stateName == 'disabled'
  ).property 'stateManager.currentState'

  isStopped: (->
    @get('isPaused') and @get('playhead') == 0
  ).property 'isPaused'

  isRecording: (->
    parentState = @getPath 'stateManager.currentState.parentState.name'
    parentState == 'record'
  ).property 'stateManager.currentState'

  playhead: 0

  play: ()->
    @get('stateManager').goToState 'enabled'

  pause: ()->
    @get('stateManager').goToState 'disabled'

  togglePlay: ->
    if @get 'isPlaying'
      @pause()
    else
      @play()

  stop: ()->
    recording = @get 'isRecording'
    @get('stateManager').goToState 'playback.disabled'
    @goto 0 if not recording

  record: ()->
    if @get 'isRecording'
      @get('stateManager').goToState 'playback'
    else
      @get('stateManager').goToState 'record'

  rewind: (speed=2)->
    if @get 'canSetPlayhead'
      @get('stateManager').goToState 'playback.rewind'

  fastforward: (speed=2)->
    if @get 'canSetPlayhead'
      @get('stateManager').goToState 'playback.fastforward'

  beginning: ->
    if @get 'canSetPlayhead'
      wasPlaying = @get('isPlaying')
      @stop()
      @play() if wasPlaying

  goto: (pos)->
    @set 'playhead', pos