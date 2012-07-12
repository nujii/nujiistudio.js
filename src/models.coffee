# Require the main app
App = require 'app'

# Assign each model a name in the application
mapping =
  'AutomationLayer': require 'models/automation-layer'
  'Clip': require 'models/clip'
  'Plugin': require 'models/plugin'
  'Project': require 'models/project'
  'Region': require 'models/region'
  'Session': require 'models/session'
  'Tempo': require 'models/tempo'
  'TimeSignature': require 'models/time-signature'
  'Track': require 'models/track'
  'User': require 'models/user'

for className, module of mapping
  App[className] = module