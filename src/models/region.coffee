
module.exports = DS.Model.extend
  # ##Properties

  begin: DS.attr 'number'
  end: DS.attr 'number'
  position: DS.attr 'number'
  fadeIn: DS.attr 'number'
  fadeOut: DS.attr 'number'

  # ##Computed Properties

  length: (()->
    @get('begin')+@get('end')
  ).property 'begin','end'

  endPosition: (()->
    @get('length')+@get('position')
  ).property 'length','position'

  # Returns an array describing the waveform in the region
  waveform: (()->

  ).property 'begin end'

  # ##Relationships

  # This is broken right now
  # clip: DS.hasOne (require 'models/clip')
