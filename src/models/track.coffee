
module.exports = DS.Model.extend
  # ##Properties

  title: DS.attr 'string'
  color: DS.attr 'string'
  isLocked: DS.attr 'boolean'
  isMuted: DS.attr 'boolean'

  # ##Computed Properties

  length: (()->
    # Find the region with the greatest 'offset+length'
    0
  ).property 'regions'

  # ##Relationships

  # ###Reverse Relationships

  # This has to be a function to avoid a circular dependency
  project: ->
    DS.belongsTo (require 'models/project')

  # ###Forward Relationships

  plugins: DS.hasMany (require 'models/plugin')
  automationLayers: DS.hasMany (require 'models/automation-layer')
  regions: DS.hasMany (require 'models/region')

  # ##Functions

  # ###Region Functions

  # TODO
  addRegion: (clip, defaults={})->

  # TODO
  removeRegion: (region)->

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

