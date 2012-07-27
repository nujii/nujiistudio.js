
Timeline = require 'lib/timeline'
Ludwig = require 'lib/timeline-adapters/ludwig'

module.exports = Em.Controller.extend
  timeline: null
  project: null

  init: ()->
    # Load the timeline.
    # This is where we set the adapter
    @set 'timeline', Timeline.create adapter: Ludwig
    # Hardcoded for now
    @loadProject '4'

  loadProject: (id)->
    project = require('models/project').find id
    @set 'project', project
    App.project = project

  title: (()->
    @get('project').get('title')
  ).property 'project'

  tracks: (()->
    @get('project').get('tracks')
  ).property 'project'