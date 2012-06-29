App = require 'app'

module.exports = Flame.ListItemView.extend

  classNames: 'track-content'

  templateBinding: '^controller.tracks'

  handlebars:
    """
    <div class="">
      <img src="images/track-test.png">
    </div>
    """