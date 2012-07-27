 
App = require 'app'

module.exports = Em.ArrayController.extend

  content: (()->
    return App.router.applicationController.get('tracks') if App.router
    return DS.RecordArray.create()
  ).property()

  addTrack: ()->
    App.project.addTrack()
    App.store.commit()

  addTestRegion: (track)->
    clip = require('models/clip').createRecord()
    track.addRegion clip,
      begin: 0
      end: 600
      position: 0
    App.store.commit()

  toggleArm: (track)->
    track.set 'isArmed', !track.get 'isArmed'
    track.store.commit()

  toggleLock: (track)->
    track.set 'isLocked', !track.get 'isLocked'
    track.store.commit()

  titleChanged: (track)->
    App.store.commit()

  didReorderContent: ()->
    App.project.changeVersion()
    App.store.commit()