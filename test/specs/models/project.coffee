
Project = require 'models/project'
Track = require 'models/track'
should = require('chai').should()

store = null

describe 'Project Model', ->

  beforeEach (done)->
    Project.FIXTURES = require 'fixtures/models/project'
    Track.FIXTURES = require 'fixtures/models/track'
    store = DS.Store.create
      revision: 4
      adapter: (require 'fixtures/fixture-adapter').create()

    done()

  afterEach (done)->
    delete Project.FIXTURES
    delete Track.FIXTURES
    Ember.run ()->
      store.destroy()
      store = null
      done()

  it 'should be defined', ->
    should.exist Project

  it 'should be able to create a new project', ->
    project = store.createRecord Project,
      title: 'Create Test Project'
    should.exist project
    project.get('title').should.equal 'Create Test Project'

  it 'should be able to find an existing project by id', (done)->
    project = store.find Project, 1

    project.addObserver 'isLoaded', ->
      should.exist project
      project.get('title').should.equal 'Test Project'
      done()

  it 'should get find associated tracks', (done)->
    project = store.find Project, 1

    project.addObserver 'isLoaded', ->
      should.exist project
      tracks = project.get 'tracks'
      should.exist tracks
      tracks.type.should.equal Track

      tracks.addObserver 'isLoaded', ->
        content = tracks.get 'content'
        # Fixture has 2 tracks
        content.length.should.equal 2
        done()

  # it 'should be able to add a new track', (done)->
  #   project = store.find Project, 1

  #   project.addObserver 'isLoaded', ->
  #     should.exist project
  #     project.addTrack()
  #     tracks = project.get 'tracks'
  #     should.exist tracks
  #     tracks.type.should.equal Track

  #     tracks.addObserver 'isLoaded', ->
  #       content = tracks.get 'content'
  #       content.length.should.equal 3
  #       done()

  # it 'should be able to remove a track', (done)->
  #   project = store.find Project, 1

  #   project.addObserver 'isLoaded', ->
  #     should.exist project
  #     tracks = project.get 'tracks'
  #     should.exist tracks
  #     tracks.type.should.equal Track

  #     tracks.addObserver 'isLoaded', ->
  #       trackOne = tracks.objectAtContent 0
  #       project.removeTrack trackOne
  #       content = tracks.get 'content'
  #       content.length.should.equal 1
  #       done()

  # it 'should be able to switch track positions', (done)->
  #   project = store.find Project, 1

  #   project.addObserver 'isLoaded', ->
  #     should.exist project
  #     project.addTrack()
  #     tracks = project.get 'tracks'
  #     should.exist tracks
  #     tracks.type.should.equal Track

  #     tracks.addObserver 'isLoaded', ->
  #       # Get the two tracks
  #       trackOne = tracks.objectAtContent 0
  #       trackTwo = tracks.objectAtContent 1
  #       # Switch 'em
  #       project.switchTracks trackOne, trackTwo
  #       content = tracks.get 'content'
  #       # It shouldnt have removed any
  #       content.length.should.equal 2
  #       # They should be equal to their old objects;
  #       # just in a new place
  #       oldTrackTwo = tracks.objectAtContent 0
  #       oldTrackTwo.get('id').should.equal trackTwo.get('id')
  #       oldTrackOne = tracks.objectAtContent 1
  #       oldTrackOne.get('id').should.equal trackOne.get('id')
  #       done()
