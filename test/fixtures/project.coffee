
module.exports =
  id: 1
  title: 'Test Project'
  created: new Date()
  isPublic: false

  tempos: [
    position: 0
    tempo: 120
  ]

  timesignatures: [
    position: 0
    numerator: 4
    denominator: 4
  ]

  tracks: [
    title: 'Track One'
    color: 'red'
    isLocked: false
    isMuted: false

    regions: [
      begin: 0
      end: 50
      position: 0
      fadeIn: .1
      fadeOut: .2
    ,
      begin: 0
      end: 50
      position: 50
      fadeIn: .4
      fadeOut: .3
    ]
  ,
    title: 'Track Two'
    color: 'blue'
    isLocked: true
    isMuted: true

    regions: [
      begin: 0
      end: 30
      position: 20
      fadeIn: .1
      fadeOut: .2
    ,
      begin: 0
      end: 70
      position: 80
      fadeIn: .2
      fadeOut: .6
    ]
  ]