
goog.provide('nujii.studio.models.ProjectCollection');

goog.require('backbone');

goog.require('nujii.studio.models.Project');
goog.require('nujii.studio.defs');

nujii.studio.models.ProjectCollection = Backbone.Collection.extend({

    // Reference to this collection's model.
    model: nujii.studio.models.Project,
    url : nujii.studio.defs.BASE_URL+'/projects'

});
