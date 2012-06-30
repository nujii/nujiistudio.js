
module.exports = Em.Router.extend
  enableLogging: true

  root: Em.State.extend
    goHome: Ember.State.transitionTo("home")
    viewArrange: Ember.State.transitionTo("arrange")

    index: Em.State.extend
      route: "/"
      connectOutlets: (router, context) ->
        router.get("applicationController").connectOutlet "home"
    
    arrange: Em.State.extend
      route: "/arrange"
      connectOutlets: (router, context) ->
        router.get("arrangeController").connectOutlet "arrange"