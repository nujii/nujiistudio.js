
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

  # Let's get the basics working first

  #plugins: DS.hasMany (require 'models/plugin'),
  #  embedded: true
  #automationLayers: DS.hasMany (require 'models/automation_layer'),
  #  embedded: true
  
  regions: DS.hasMany (require 'models/region'),
    embedded: true

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

