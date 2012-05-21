
goog.provide('nujii.studio.models.Track');

goog.require('backbone');

goog.require('nujii.studio.models.RegionCollection');

nujii.studio.models.Track = nujii.studio.models.ShareModel.extend({

    // Default attributes
    defaults: function() {
        return {
            title: "Untitled Track",
            regions: [],
            isMuted: false,
            isSolo: false,
            isVisible: true,
            volume: 1.0,
            pan: 0.0
        };
    },

    initialize: function () {
        
    },

    parse: function (attr) {
        if (attr._doc) {
            this.doc = attr._doc;
            delete attr._doc;
        }
        if (!goog.isDefAndNotNull(this.doc.get())) {
            this.doc.set(this.defaults());
        }
        return attr;
    }

});
