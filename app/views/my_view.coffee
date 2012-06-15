App = require 'app'

App.Views.MyView = Em.View.extend(
  templateName: require 'templates/my_template'
  contentBinding: 'App.myController.theMan'
  click: (e) ->
    lyrics = @get('content').get('lyrics')
    alert lyrics
)