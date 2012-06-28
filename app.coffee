appjs = require 'appjs'

settings =
  width: 800
  height: 600
  autoResize: false

app = appjs.init()

app.on "window_ready", ()->
  console.log("Event WindowReady called")

  window.show()

app.use app.staticRouter './public'

window = app.createWindow 'http://appjs', settings