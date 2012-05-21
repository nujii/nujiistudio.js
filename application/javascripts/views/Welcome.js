
goog.provide('nujii.studio.views.Welcome');

goog.require('goog.dom');
goog.require('backbone');

goog.require('nujii.studio.views.ProjectListItem');

nujii.studio.views.Welcome = Backbone.View.extend({

    el: goog.dom.getElement('index'),

    events: {

    },

    initialize: function() {
        var app = nujii.studio.App
        app.projects.bind('add',   this.addOne, this);
        app.projects.bind('reset', this.addAll, this);
        app.projects.bind('all',   this.render, this);

        app.projects.fetch();
    },

    // Re-rendering the App just means refreshing the statistics -- the rest
    // of the app doesn't change.
    render: function() {
        goog.dom.setProperties(this.el, {style: ''});
    },

    // Add a single todo item to the list by creating a view for it, and
    // appending its element to the `<ul>`.
    addOne: function(project) {
        var view = new nujii.studio.views.ProjectListItem({model: project});
        goog.dom.append(goog.dom.getElement('project-listing'), view.render().el);
    },

    // Add all items in the **Projects** collection at once.
    addAll: function() {
        goog.dom.getElement('project-listing').innerHTML = '';
        nujii.studio.App.projects.each(this.addOne);
    },

    close: function () {
        goog.dom.setProperties(this.el, {style: 'display: none'});
    }

});
