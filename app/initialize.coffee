
window.App = require 'app'

require 'templates'
require 'models'
require 'controllers'
require 'views'

Ember.VIEW_PRESERVES_CONTEXT = true
Ember.CP_DEFAULT_CACHEABLE = true

App.reopen
  ApplicationController: Em.Object.extend()
  ApplicationView: 
    Em.View.extend 
      templateName: require 'views/templates/application'
  Router: 
    Em.Router.extend
      enableLogging: true
      location: 'hash'

      root: Em.State.extend

        # STATES
        index: Em.State.extend
          route: '/'
          redirectsTo: 'arrange'

        connect: Em.State.extend
          route: '/connect'

        arrange: Em.State.extend
          route: '/arrange'
          connectOutlets: (router) ->
            applicationController = NS.get('applicationController')
            applicationController.connectOutlet NS.ArrangeView
  tracksController: 
    App.TracksController.create
      content: [{title: "test", volume: "-20", armed: true},{title: "other test", volume: "-10"}]

App.initialize(App.Router.create())