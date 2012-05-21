
goog.provide('nujii.studio.App');

goog.require('nujii.studio.AppRouter');
goog.require('nujii.studio.models.ProjectCollection');

nujii.studio.App = new nujii.studio.AppRouter(); 
nujii.studio.App.projects = new nujii.studio.models.ProjectCollection();

Backbone.history.start({pushState: true});
