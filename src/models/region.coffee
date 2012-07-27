
Base = require 'models/base'

module.exports = Region = Base.extend

  init: ->
    @_super()
    @addObserver 'endPosition', @, ->
      track = @get 'track'
      if track
        track.findLength()

  # ##Properties

  begin: DS.attr 'number'
  end: DS.attr 'number'
  position: DS.attr 'number'
  fadeIn: DS.attr 'number'
  fadeOut: DS.attr 'number'

  # ##Computed Properties

  length: (()->
    @get('end')-@get('begin')
  ).property 'begin','end'

  endPosition: (()->
    @get('length')+@get('position')
  ).property 'length','position'

  maxLength: (()->
    @get('clip').get 'length'
  ).property 'clip'

  # Returns an array describing the waveform in the region
  waveform: (()->

  ).property('begin', 'end', 'clip').cacheable()

  # ##Relationships

  track: DS.belongsTo 'App.Track'

  # This is broken right now
  # clip: DS.hasOne (require 'models/clip')

# Reopen the class to describe the type
Region.reopenClass
  # ##Type Properties
  path: 'regions'
