
App = require 'app'

should = require('chai').should()

describe 'App', ->
  it 'should defined', ->
    should.exist App
  # it 'should have a router', ->
  #   should.exist App.router