# Require the application and assign it to a global
window.App = App = require 'app'

# Setup the router
App.Router = require 'router'

# Require the different components
#require 'templates'
require 'models'
require 'controllers'
require 'views'

# Initialize the Ember application
App.initialize()
