
Project = require 'models/project'
Track = require 'models/track'
should = require('chai').should()

# Create a test store
store = DS.Store.create
  revision: 4


# Preload it with some projects
store.load Project, require 'fixtures/project'

describe 'Project Model', ->
  it 'should defined', ->
    should.exist Project

  it 'should be able to create a new project', ->
    project = store.createRecord Project,
      title: 'Create Test Project'
    should.exist project
    project.get('title').should.equal 'Create Test Project'

  it 'should be able to find an existing project by id', ->
    project = store.find Project, 1
    should.exist project
    project.get('title').should.equal 'Test Project'

  it 'should get embedded tracks', ->
    project = store.find Project, 1
    should.exist project
    should.exist project.get 'tracks'
    project.get('tracks').length.should.equal 2
