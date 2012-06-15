App = require 'app'

App.Models.MyModel = Em.Object.extend(
  firstName: null
  lastName: null
  lyrics: null
  fullName: (() -> "#{@get('firstName')} #{@get('lastName')}").property('firstName', 'lastName')
)