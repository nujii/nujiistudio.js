# This object represents a project in Nujii Studio

Base = require 'models/base'

module.exports = Project = Base.extend
  # ##Properties

  title: DS.attr 'string'
  created: DS.attr 'date'
  isPublic: DS.attr 'boolean'
  
  length: 0

  # ##Computed Properties
  
  # Iterate over the tracks and return the longest track.
  findLength: ()->
    # TODO We're returning 0 for now
    maxLength = 0
    tracks = @get('tracks').toArray()
    for track in tracks
      newLength = track.get('length')
      maxLength = newLength if newLength > maxLength
    
    @set 'length', maxLength

  # ##Relationships
  
  # Each project has an owner/creator
  owner: DS.belongsTo (require 'models/user')

  # The project can allow many users to edit it
  collaborators: DS.hasMany (require 'models/user')

  # Global Automation Layers
  tempos: DS.hasMany (require 'models/tempo')
  timesignatures: DS.hasMany (require 'models/time-signature')

  tracks: DS.hasMany (require 'models/track')

  # Clips to which the project has access
  clips: DS.hasMany (require 'models/clip')

  # ##Functions
  
  # ###Track Functions

  addTrack: (defaults = {})->
    @addRelObject require('models/track'), defaults, 'tracks', 'project'

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

# Reopen the class to describe the type
Project.reopenClass
  # ##Type Properties
  isRoot: true
  path: 'info'

  # ##Type default values
  defaults:
    info:
      title: 'New Project'
    tracks: {}
    regions: {}
    clips: {}
