
should = require('chai').should()

Adapter = require 'lib/sharejs-adapter'
Project = require 'models/project'

store = null

describe 'ShareJS Adapter', ->

  beforeEach (done)->
    store = DS.Store.create
      revision: 4
      adapter: Adapter.create()

    done()

  afterEach (done)->
    Ember.run ()->
      store.destroy()
      store = null
      done()

  it 'should be defined', ->
    should.exist Adapter

  it 'should be able to open a project', (done)->
    project = store.find Project, 'test1'
    project.addObserver 'isLoaded', ->
      done()

  it 'shoud update the other copies', (done)->
    project = store.find Project, 'test1'
    callback = ->
      project.set 'title', 'Project at '+new Date()
      otherCopy = store.find Project, 'test1'
      otherCopy.addObserver 'data', ()->
        done()
      store.commit()

    isLoaded = project.get 'isLoaded'
    project.addObserver 'isLoaded', callback if not isLoaded
    callback() if isLoaded