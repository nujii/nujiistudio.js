# load all your views here

App = require 'app'

#global
App.ApplicationView = require './views/application_view'
App.ControlView = require './views/control_view'

#arrange
App.ArrangeView = require './views/arrange_view'
App.ArrangeTrackView = require './views/arrange_track_view'