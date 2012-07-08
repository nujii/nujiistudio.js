# Let's get that router going
module.exports = Em.Router.extend
  # Enable this for development.
  # The default will be true until we go into production.
  enableLogging: true

  # Setup the root state
  root: Em.State.extend

    # Our actions go here
    goHome: Ember.State.transitionTo("home")
    viewArrange: Ember.State.transitionTo("arrange")

    # The index state shows up when users open the application
    index: Em.State.extend
      route: "/"
      connectOutlets: (router, context) ->
        router.get("applicationController").connectOutlet "home"
    
    # The arrange state is shown in the arrange tab
    arrange: Em.State.extend
      route: "/arrange"
      connectOutlets: (router, context) ->
        router.get("arrangeController").connectOutlet "arrange"