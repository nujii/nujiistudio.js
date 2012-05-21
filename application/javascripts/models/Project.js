
goog.provide('nujii.studio.models.Project');

goog.require('backbone');

goog.require('nujii.studio.models.ShareModel');
goog.require('nujii.studio.models.TrackCollection');

nujii.studio.models.Project = nujii.studio.models.ShareModel.extend({

    initialize: function() {

    },

    // Default attributes
    defaults: function() {
        return {
            title: 'Untitled Project',
            tracks: [],
            bpm: 120,
            meter_nom: 4,
            meter_dnom: 4,
            volume: 1.0
        };
    },

    fetch: function (options) {
        options = options ? _.clone(options) : {};
        var model = this;
        var success = options.success;
        options.success = function(doc) {
            model.doc = doc;
            var options = {doc: doc.at('tracks')};
            model.tracks = new nujii.studio.models.TrackCollection(false, options);

            doc.on('change', function(op) {
                for (var i = op.length - 1; i >= 0; i--) {
                    model.trigger('change:' + op[i].p.join(':'), model, model.get(op[i].p[0]));
                }
                model.trigger('change', model);
            });
            if (!options.silent) {
                options.changes = model.doc.snapshot;
                model.change(options);
            }
            if (success) success(model);
        };
        options.error = Backbone.wrapError(options.error, model, options);
        return this.sync('read', this, options);
    },

    sync: function(method, model, options) {
        sharejs.open(model.id, 'json', nujii.studio.defs.BASE_URL+'/channel', function(error, doc) {
            if (error) {
                options.error(error);
            }
            else {
                if (doc.created) {
                    var defaults = model.defaults();
                    doc.submitOp([{p:[], od:null, oi:defaults}], function (opError, op) {
                        if (opError) {
                            options.error(opError);
                        }
                        else {
                            options.success(doc);
                        }
                    });
                }
                else {
                    options.success(doc);
                }
            }
        });
    }

});
