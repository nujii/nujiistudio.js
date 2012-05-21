
goog.provide('nujii.studio.views.NewProject');

goog.require('goog.dom');
goog.require('backbone');
goog.require('share');

goog.require('nujii.studio.defs');
goog.require('nujii.studio.models.TrackCollection');

nujii.studio.views.NewProject = Backbone.View.extend({

    el: goog.dom.getElement('project'),

    events: {

    },

    initialize: function() {
    	var _this = this;
    	sharejs.open(this.id, 'json', nujii.studio.defs.BASE_URL+'/channel', function(error, doc) {
    		_this.doc = doc;
    		if (doc.create) {
    			doc = _this.defaults;
    		}
    		_this.sync('read');
    	});
    },

    // Re-rendering the App just means refreshing the statistics -- the rest
    // of the app doesn't change.
    render: function() {
        
    },

    close: function () {
    	if (this.doc) {
			this.doc.close();
			this._old_doc = this.doc;
    	};
		this.doc = undefined;
    },

    sync: function(method, options) {
    	console.log(arguments);
    }

});
