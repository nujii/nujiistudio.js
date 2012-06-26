App = require 'app'

module.exports = Flame.RootView.extend

  childViews: "splitView".w()
  splitView: Flame.VerticalSplitView.extend(
    leftWidth: 250
    minLeftWidth: 200
    # layout:
    #   top: 50
    #   left: 0

    leftView: Flame.View.extend(
      childViews: "titleView searchFieldView listView".w()
      titleView: Flame.View.extend(
        layout:
          height: 35
          left: 0
          right: 0
          top: 0

        classNames: [ "title", "btn" ]
        childViews: "aboutButtonView labelView addButtonView".w()
        aboutButtonView: Flame.ButtonView.extend(
          acceptsKeyResponder: false
          layout:
            top: 5
            left: 5
            width: 25

          title: "?"
          action: ->
            App.AboutPanel.create().popup()
        )
        addButtonView: Flame.ButtonView.extend(
          acceptsKeyResponder: false
          layout:
            top: 5
            left: 35
            width: 25

          title: '+'
          action: ->
            console.log 'Add Track'
        )
        labelView: Flame.LabelView.extend(
          layout:
            left: 35
            right: 35
            top: 7

          textAlign: Flame.ALIGN_CENTER
          handlebars: 'Tracks'
        )
      )
      searchFieldView: Flame.SearchTextFieldView.extend(
        layout:
          top: 42
          left: 5
          right: 5

        placeholder: "Search"
        valueBinding: "parentView.parentView.parentView.controller.searchText"
      )
      listView: Flame.ListView.extend(
        layout:
          top: 70
          left: 0
          right: 0
          bottom: 0

        selectionBinding: "parentView.parentView.parentView.controller.selected"
        itemViewClass: Flame.ListItemView.extend(handlebars: "{{content.fullName}}")
      )
    )
    rightView: Flame.View.extend(
      layoutManager: Flame.VerticalStackLayoutManager.create(
        topMargin: 5
        spacing: 5
        bottomMargin: 5
      )
      layout:
        top: 20
        left: 20
        right: 20

      childViews: "formView deleteButtonView".w()
      formView: Flame.FormView.extend(
        objectBinding: "parentView.parentView.parentView.controller.selected"
        labelWidth: 80
        controlWidth: 200
        properties: [
          property: "firstName"
          label: "First name"
          validation: "Please provide a first name"
          ,
          property: "lastName"
          label: "Last name"
          validation: "Please provide a last name"
        ]
      )
      deleteButtonView: Flame.ButtonView.extend(
        layout:
          left: 230
          width: 80

        title: "Delete"
        targetBinding: "parentView.parentView.parentView.controller"
        action: "confirmDelete"
      )
    )
  )

App.AboutPanel = Flame.Panel.extend(
  layout:
    width: 350
    height: 160
    centerX: 0
    centerY: -50

  title: "Flame.js Example Application"
  allowMoving: true
  contentView: Flame.View.extend(
    layout:
      top: 50
      left: 20
      right: 20
      height: 150

    handlebars: "<p>This is an example application for " + "<a href=\"https://github.com/flamejs/flame.js\" target=\"_blank\">Flame.js</a>.</p>" + "<p>The source can be found on <a href=\"https://github.com/flamejs/flame-address-book\"" + " target=\"_blank\">GitHub</a>.</p>" + "<p>Also check out the <a href=\"http://flamejs.github.com/flame-address-book/docs/app.html\"" + " target=\"_blank\">annotated source code</a>.</p>"
  )
)