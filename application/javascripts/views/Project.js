
goog.provide('nujii.studio.views.Project');

goog.require('goog.dom');
goog.require('backbone');
goog.require('share');

goog.require('nujii.studio.defs');
goog.require('nujii.studio.models.Project');
goog.require('nujii.studio.templates.project');
goog.require('nujii.studio.views.Collection');
goog.require('nujii.studio.views.TrackListingItem');

nujii.studio.views.Project = Backbone.View.extend({

    el: goog.dom.getElement('project-info'),

    events: {
        "change .project-volume": "changeVolume",
        "click .project-tempo": "changeTempo"
    },

    initialize: function() {
        this.project = new nujii.studio.models.Project({id: this.id});

        // Listen for changes to the model
        this.project.on('change:title', this.updateTitle, this);
        this.project.on('change:volume', this.updateVolume, this);
        this.project.on('change:tempo', this.updateTempo, this);

        this.project.on('change:tracks', this.updateTracks, this);

        // Lets load that bad boy
        this.project.fetch();
    },

    updateTracks: function () {
        if (!this.trackView) {
            this.trackView = new nujii.studio.views.Collection({
              collection           : this.project.tracks,
              childViewConstructor : nujii.studio.views.TrackListingItem,
              childViewTagName     : 'li',
              el                   : $('#track-list')
            });
        }
    },

    render: function() {
        var json = this.project.toJSON();
        this.$el.html(nujii.studio.templates.project.tempView(json));
        this.volumeEl = this.$('.project-volume');
        this.tempoEl = this.$('.project-tempo');
    },

    updateTitle: function (event) {
        this.$('.project-title').html(this.project.get('title'));
    },

    changeTempo: function (event) {
        var val = event.target.value;
        this.project.set('tempo', val, {silent: true});
    },

    updateTempo: function (event) {
        this.tempoEl.val(this.project.get('tempo'));
    },

    changeVolume: function (event) {
        var val = event.target.value;
        this.project.set('volume', val, {silent: true});
    },

    updateVolume: function (event) {
        this.volumeEl.val(this.project.get('volume'));
    },

    close: function () {
        // if (this.doc) {
        //     this.doc.close();
        //     this._old_doc = this.doc;
        // };
        // this.doc = undefined;
    }

});
