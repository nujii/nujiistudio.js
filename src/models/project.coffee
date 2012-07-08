# This object represents a project in Nujii Studio

module.exports = DS.Model.extend
  # ##Properties

  title: DS.attr 'string'
  created: DS.attr 'date'
  isPublic: DS.attr 'boolean'

  # ##Computed Properties
  
  # Iterate over the tracks and return the longest track.
  length: (()->
    # TODO We're returning 0 for now
    0
  ).property 'tracks'

  # ##Relationships
  
  # Each project has an owner/creator
  owner: DS.belongsTo (require 'models/user')

  # The project can allow many users to edit it
  collaborators: DS.hasMany (require 'models/user')

  # Global Automation Layers
  tempos: DS.hasMany (require 'models/tempo'),
    embedded: true
  timesignatures: DS.hasMany (require 'models/time_signature'),
    embedded: true

  tracks: DS.hasMany (require 'models/track'),
    embedded: true

  # Clips to which the project has access
  clips: DS.hasMany (require 'models/clip'),
    embedded: true

  # ##Functions
  
  # ###Track Functions

  # TODO
  addTrack: (defaults = {})->

  # TODO
  removeTrack: (track)->
    Ember.assert 'Track must be a real track', !!track

  # TODO
  switchTracks: (track1, track2)->
    Ember.assert 'Tracks must not be null', !!track1 && !!track2

  # TODO
  duplicateTrack: (track)->
    Ember.assert 'Track must be a real track', !!track

  # ###Collaborator Functions

  # TODO
  addCollaborator: (user)->
    Ember.assert 'User must not be null', !!user

  # TODO
  removeCollaborator: (user)->
    Ember.assert 'User must not be null', !!user


