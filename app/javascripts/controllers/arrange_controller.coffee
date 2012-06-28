
module.exports = Em.Controller.extend
  title: (()->
    return 'Test'
  ).property('title')