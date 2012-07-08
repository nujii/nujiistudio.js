# Require the main app
App = require 'app'

# Assign each view a name in the application

# The main views are assigned here
App.ApplicationView = require 'views/application_view'
App.ControlView = require 'views/control_view'

# The views pertaining to the arrange view go here
App.ArrangeView = require 'views/arrange_view'
App.ArrangeHeaderView = require 'views/arrange_header_view'
App.ArrangeTrackView = require 'views/arrange_track_view'