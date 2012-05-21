
goog.provide('nujii.studio.AppRouter');

goog.require('nujii.studio.views.Welcome');
goog.require('nujii.studio.views.Project');
//goog.require('nujii.studio.views.NewProject');

nujii.studio.AppRouter = Backbone.Router.extend({

    routes: {
        "" : "edit",
        "new" : "new",
        "projects/:id": "edit"
    },

    views: {},

    index: function() {
        this._switchViews(this._cachedView('indexView', nujii.studio.views.Welcome));
    },

    new: function() {
        console.log('new');
        //this._switchViews(this._cachedView('newProjectView', nujii.studio.views.NewProject));
    },

    edit: function(id) {
        id = 'My Project';
        var view = (goog.isDefAndNotNull(this.views.projectView) 
                    && this.views.projectView.id == id)?
                        (this.views.projectView):
                        (new nujii.studio.views.Project({id: id}));

        this.views.projectView = view;
        this._switchViews(view);
    },

    _cachedView: function (index, modelClass, args) {
        if (!goog.isDefAndNotNull(this.views[index])) {
            this.views[index] = new modelClass(args);
        }
        return this.views[index];
    },

    _switchViews: function (view) {
        if (this.view) {
            this.view.close();
        }
        this.view = view;
        this.view.render();
    }

});
