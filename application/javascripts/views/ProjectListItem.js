goog.provide('nujii.studio.views.ProjectListItem');

goog.require('goog.dom');
goog.require('backbone');

goog.require('nujii.studio.templates.welcome');

nujii.studio.views.ProjectListItem = Backbone.View.extend({

    //... is a list tag.
    tagName:  "li",

    // The DOM events specific to an item.
    events: {
        "click a" : "openProject"
    },

    // The TodoView listens for changes to its model, re-rendering.
    initialize: function() {
        this.model.bind('change', this.render, this);
        this.model.bind('destroy', this.remove, this);
    },

    // Re-render the info of the project
    render: function() {
        var html = nujii.studio.templates.welcome.projectListItem(this.model.toJSON());
        goog.dom.getElement(this.el).innerHTML = html;
        return this;
    },

    // Load the Project into view
    openProject: function(link) {
        link.preventDefault();
        nujii.studio.App.navigate(link.target.pathname, {trigger: true});
        return false;
    }
});
