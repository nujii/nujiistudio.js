# Sessions represent user interaction with a project

module.exports = DS.Model.extend
  # Transport Properties
  isPlaying: DS.attr 'boolean'
  isStopped: (()->
    !@isPlaying
  ).property 'isPlaying'
  playheadPosition: DS.attr 'number'
  isFastForwarding: DS.attr 'boolean'
  isRewinding: DS.attr 'boolean'

  # User can shift all of the tempos in the project to make
  # it easier for recording
  tempoShift: DS.attr 'number'

  # Each session has a project.
  # This is broken right now...
  # project: DS.hasOne (require 'models/project')