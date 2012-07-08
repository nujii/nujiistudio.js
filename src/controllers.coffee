# Require the main app
App = require 'app'

# Assign each controller a name in the application
App.ApplicationController = require 'controllers/application_controller'
App.ArrangeController = require 'controllers/arrange_controller'
App.TracksController = require 'controllers/tracks_controller'
