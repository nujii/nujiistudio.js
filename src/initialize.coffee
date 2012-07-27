# Require the application and assign it to a global
window.App = App = require 'app'

# Setup the router
App.Router = require 'router'
require 'lib/sharejs-adapter'

# Require the different components
#require 'templates'
require 'models'
require 'controllers'
require 'views'

# Add the data store
Adapter = require 'lib/sharejs-adapter'
Project = require 'models/project'

App.store = DS.Store.create
  revision: 4
  adapter: Adapter.create()

App.transport = (require 'lib/backend/transport').create()

# Initialize the Ember application
App.initialize()