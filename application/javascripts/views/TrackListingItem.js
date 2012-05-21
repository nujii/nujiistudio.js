
goog.provide('nujii.studio.views.TrackListingItem');

goog.require('goog.dom');
goog.require('backbone');
goog.require('share');

goog.require('nujii.studio.defs');
goog.require('nujii.studio.models.TrackCollection');
goog.require('nujii.studio.templates.tracklist');

nujii.studio.views.TrackListingItem = Backbone.View.extend({

    events: {
        "click .add-track": "addTrack"
    },

    initialize: function(options) {
        this.track = options.track;
        this.tag = options.tag;
    },

    render: function() {
        var json = this.project.tracks.toJSON();
        var html = nujii.studio.templates.tracklist.index({tracks: json});
        this.$el.html(html);
    },

    addTrack: function() {
        this.project.tracks.add({});
    },

    removeTrack: function () {

    },

    updateTracks: function() {

    },

    close: function () {
    }

});
