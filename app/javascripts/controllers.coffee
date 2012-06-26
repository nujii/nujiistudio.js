# load all your controllers here

App = require 'app'

App.ApplicationController = require './controllers/application_controller'
App.ArrangeController = require './controllers/arrange_controller'
#require './controllers/tracks_controller'

App.Person = Ember.Object.extend(Flame.Validatable,
  validations:
    firstName: [ Flame.Validator.notBlank ]
    lastName: [ Flame.Validator.notBlank ]

  fullName: ->
    "%@ %@".fmt @get("firstName"), @get("lastName").property("firstName", "lastName").cacheable()
)
App.tracksController = Ember.Controller.create(
  all: [ App.Person.create(
    firstName: "Luke"
    lastName: "Skywalker"
  ), App.Person.create(
    firstName: "Obi-Wan"
    lastName: "Kenobi"
  ), App.Person.create(
    firstName: "Darth"
    lastName: "Vader"
  ), App.Person.create(
    firstName: "Han"
    lastName: "Solo"
  ), App.Person.create(
    firstName: "Master"
    lastName: "Yoda"
  ), App.Person.create(
    firstName: "Leia"
    lastName: "Organa"
  ) ]
  searchResults: null
  selected: null
  searchText: ""
  init: ->
    @_super()
    @doSearch()

  doSearch: ->
    searchText = @get("searchText")
    searchResults = @get("all")
    @set("searchResults", searchResults)
  createPerson: ->
    person = App.Person.create(
      firstName: "New"
      lastName: "Person"
    )
    @get("all").pushObject person
    @set "selected", person

  confirmDelete: ->
    selected = @get("selected")
    self = this
    if selected
      Flame.AlertPanel.warn(
        title: "Confirm Delete"
        message: "Are you sure you want to delete %@?".fmt(selected.get("fullName"))
        onConfirm: ->
          @_super()
          self.deleteSelectedPerson()
      ).popup()

  deleteSelectedPerson: ->
    selected = @get("selected")
    @set "selected", null
    @get("all").removeObject selected
)