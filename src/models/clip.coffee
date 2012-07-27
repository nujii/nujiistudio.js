
Base = require 'models/base'

module.exports = Clip = Base.extend
  source: DS.attr 'string'
  
# Reopen the class to describe the type
Clip.reopenClass
  # ##Type Properties
  path: 'clips'
