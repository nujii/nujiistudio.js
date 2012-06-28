App = require 'app'

module.exports = Ember.View.extend

  templateName: require 'templates/arrange'

  leftWidth: 250
  minLeftWidth: 250

  #leftView: App.ArrangeSidebar.create()
  #rightView: App.ArrangeContent.create()

  init: ()->
    @._super()



  didInsertElement: ()->
    @.$('.arrange-content').lionbars()
    @.$('.arrange-trackbody').lionbars()