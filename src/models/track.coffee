
Base = require 'models/base'

module.exports = Track = Base.extend
  # ##Properties

  title: DS.attr 'string'
  color: DS.attr 'string'
  isLocked: DS.attr 'boolean'
  isMuted: DS.attr 'boolean'
  _version: DS.attr 'string'

  # ##Computed Properties

  length: 0

  findLength: ()->
    # Find the region with the greatest 'offset+length'
    longest = 0
    for region in @get('regions').toArray()
      newLongest = region.get('endPosition')
      longest = newLongest if newLongest > longest
    @set 'length',longest

    @get('project').findLength()

  isEditable: (()->
    !@.get 'isLocked'
  ).property 'isLocked'

  # ##Relationships

  # ###Reverse Relationships

  # This has to be a function to avoid a circular dependency
  project: DS.belongsTo 'App.Project'

  # ###Forward Relationships

  plugins: DS.hasMany (require 'models/plugin')
  automationLayers: DS.hasMany (require 'models/automation-layer')
  regions: DS.hasMany (require 'models/region')

  # ##Functions

  # ###Region Functions

  # TODO
  addRegion: (clip, defaults={})->
    newRegion =
      @addRelObject require('models/region'), defaults, 'regions', 'track'
    newRegion.set 'clip', newRegion

  # TODO
  removeRegion: (region)->


  moveRegionToTrack: (region)->
    parentTrack = region.get 'track'
    if parentTrack != @
      parentTrack.get('regions').removeObject region
      region.set 'track', @
      @get('regions').pushObject region
      #Hack for the relationship bug
      parentTrack.changeVersion()
      @changeVersion()

  # ###Plugin Functions

  # TODO
  addPlugin: (plugin, defaults={})->

  # TODO
  removePlugin: (plugin)->

  # ###Automation Layer Functions

  # TODO
  addAutomationLayer: (defaults={})->

  # TODO
  removeAutomationLayer: (layer)->

# Reopen the class to describe the type
Track.reopenClass
  # ##Type Properties
  path: 'tracks'