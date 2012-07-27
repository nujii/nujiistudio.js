# Require the main app
App = require 'app'

# Assign each view a name in the application

# The main views are assigned here
App.ApplicationView = require 'views/application_view'
App.ControlView = require 'views/control_view'

# Global
App.GlobalRegionView = require 'views/global_region_view'

# The views pertaining to the arrange view go here
App.ArrangeView = require 'views/arrange_view'
App.ArrangeHeaderView = require 'views/arrange_header_view'
App.ArrangeTrackView = require 'views/arrange_track_view'
App.ArrangeTrackTextFieldView = require 'views/arrange_track_text_field_view'
App.ArrangeRegionView = require 'views/arrange_region_view'