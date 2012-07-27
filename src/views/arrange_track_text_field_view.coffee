module.exports = Flame.TextFieldView.extend
  classNames: [ "track-title" ]

  layout:
    left: 0
    top: 0
    width: '100px'

  controllerBinding: '^controller'

  insertNewline: ->
    @commitTitle()

  commitTitle: ->
    @get('controller').titleChanged()

  textField: Ember.TextField.extend(Flame.EventManager, Flame.FocusSupport,
    classNameBindings: [ "isInvalid", "isEditableLabel", "isFocused" ]
    acceptsKeyResponder: true
    type: Flame.computed.trueFalse("parentView.isPassword", "password", "text")
    isInvalid: Flame.computed.equals("parentView.isValid", false)
    valueBinding: "^value"
    placeholderBinding: "^placeholder"
    isEditableLabelBinding: "^isEditableLabel"
    isVisibleBinding: "^isVisible"

    keyUp: ->
      @_elementValueDidChange()
      false

    didLoseKeyResponder: ->
      @get('parentView').commitTitle()
      @_super()

    insertNewline: ->
      false

    cancel: ->
      false

    mouseDown: ->
      Flame.ALLOW_BROWSER_DEFAULT_HANDLING

    mouseMove: ->
      Flame.ALLOW_BROWSER_DEFAULT_HANDLING

    mouseUp: ->
      Flame.ALLOW_BROWSER_DEFAULT_HANDLING
  )