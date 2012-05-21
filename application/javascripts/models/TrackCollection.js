
goog.provide('nujii.studio.models.TrackCollection');

goog.require('backbone');

goog.require('nujii.studio.models.Track');

nujii.studio.models.TrackCollection = Backbone.Collection.extend({

    // Reference to this collection's model.
    model: nujii.studio.models.Track,

    doc: null,

    initialize: function(models, options) {
        this.doc = options.doc;

        this.length = this.doc.get().length;

        for (var i = 0; i < this.length; i++) {
            var modelData = this.doc.get()[i];
            var model = new this.model(modelData);
            model.doc = this.doc.at(i);
            this.models.push(model);
        }

        var _collection = this;

        this.doc.on('insert', function (position, data) {
            console.log(data);
            var model = new _collection.model(data);
            model.doc = _collection.doc.at(position);
            _collection.models.splice(position, 0, model);
            _collection.trigger('add', _collection, model);
        });

        this.doc.on('delete', function (position, data) {
            _collection.models.splice(position, 1);
            _collection.trigger('remove', _collection, position);
        });
    },

    // Add a model, or list of models to the set. Pass **silent** to avoid
    // firing the `add` event for every new model.
    add: function(models, options) {
        var i, index, length, model;
        options || (options = {});
        models = _.isArray(models) ? models.slice() : [models];

        index = options.at != null ? options.at : this.doc.get().length;

        for (i = 0, length = models.length; i < length; i++) {
            var defaults = this.model.prototype.defaults();
            var modelData = _.extend(defaults, models[i]);
            this.doc.insert(i+index, modelData);
        }
        return this;
    },

    // Remove a model, or a list of models from the set. Pass silent to avoid
    // firing the `remove` event for every model removed.
    remove: function(models, options) {
        var i, l, index, model;
        options || (options = {});
        models = _.isArray(models) ? models.slice() : [models];
        for (i = 0, l = models.length; i < l; i++) {
            model = models[i];
            model.doc.remove();
        }
        return this;
    },

    // Add a model to the end of the collection.
    push: function(model, options) {
        this.add(model, options);
        return model;
    },

    // Remove a model from the end of the collection.
    pop: function(options) {
        var model = this.at(this.doc.get().length - 1);
        this.remove(model, options);
        return model;
    },

    // Add a model to the beginning of the collection.
    unshift: function(model, options) {
        this.add(model, _.extend({at: 0}, options));
        return model;
    },

    // Remove a model from the beginning of the collection.
    shift: function(options) {
        var model = this.at(0);
        this.remove(model, options);
        return model;
    },

    // Get the model at the given index.
    at: function(index) {
        return this.models[index];
    },

});
