
window.App = require 'app'

require 'templates'
require 'models'
require 'controllers'
require 'views'

App.reopen
  ready: ->
    @_super()
    console.log 'initializing ...'
    dude = App.Models.MyModel.create(
      firstName: 'Bob'
      lastName: 'Marley'
      lyrics: 'No Woman, No Cry!'
    )
    App.myController.set 'theMan', dude

  myController: App.Controllers.MyController.create()
  