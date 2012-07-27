
should = require('chai').should()

Transport = require 'lib/backend/transport'
transport = null

describe 'Transport', ->

  beforeEach (done)->
    transport = Transport.create()
    done()

  afterEach (done)->
    transport.removeObserver 'isPlaying', @
    done()

  it 'should be defined', ->
    should.exist Transport

  it 'should be able to set the position', (done)->
    transport.addObserver 'playhead', @, ->
      done()
    transport.goto 30

  it 'should be able to start playing', (done)->
    transport.addObserver 'isPlaying', @, ->
      done()
    transport.play()

  it 'should be able to stop after playing', (done)->
    localIsPlaying = false
    transport.addObserver 'isPlaying', @, ->
      if localIsPlaying is true
        transport.get('isStopped').should.equal true
        transport.get('playhead').should.equal 0
        done()
    transport.play()
    localIsPlaying = true
    setTimeout transport.stop(), 300

  it 'should pause the playhead position', (done)->
    transport.addObserver 'isPlaying', @, ->
      if transport.get('isPlaying') is false
        transport.get('isPaused').should.equal true
        transport.get('playhead').should.be.closeTo 300, 10
        done()
    transport.play()
    setTimeout transport.pause(), 300

