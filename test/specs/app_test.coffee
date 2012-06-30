
App = require 'app'

should = require('chai').should()

console.log App

describe 'App', ->
  it 'should defined', ->
    should.exist App
  it 'should have a router', ->
    should.exist App.router