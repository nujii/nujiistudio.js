
goog.provide('nujii.studio.models.RegionCollection');

goog.require('backbone');

goog.require('nujii.studio.models.Region');

nujii.studio.models.RegionCollection = Backbone.Collection.extend({

    // Reference to this collection's model.
    model: nujii.studio.models.Region

});
