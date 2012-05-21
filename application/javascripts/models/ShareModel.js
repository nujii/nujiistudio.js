
goog.provide('nujii.studio.models.ShareModel');

goog.require('backbone');

nujii.studio.models.ShareModel = Backbone.Model.extend({

    toJSON: function(options) {
        var attrs = (this.doc)?this.doc.get():{};
        return _.clone(attrs);
    },

    get: function (attr) {
        if (this.doc) {
            var snapshot = this.doc.get();
            return snapshot[attr];
        }
        else {
            return undefined
        }
    },

    set: function(key, value, options) {
        var attrs, attr, val;

        // Handle both `"key", value` and `{key: value}` -style arguments.
        if (_.isObject(key) || key == null) {
            attrs = key;
            options = value;
        } else {
            attrs = {};
            attrs[key] = value;
        }

        // Extract attributes and options.
        options || (options = {});
        if (!attrs) return this;
        if (attrs instanceof Backbone.Model) attrs = attrs.toJSON;
        if (options.unset) for (attr in attrs) attrs[attr] = void 0;

        // Run validation.
        if (!this._validate(attrs, options)) return false;

        // Check for changes of `id`.
        if (this.idAttribute in attrs) this.id = attrs[this.idAttribute];

        // Check that we have the document before they start changing stuff
        if (!this.doc) return false;

        var changes = options.changes = {};
        var now = (this.doc)?this.doc.get():{};
        var escaped = this._escapedAttributes;
        var prev = this._previousAttributes || {};

        // For each `set` attribute...
        for (attr in attrs) {
            val = attrs[attr];

            // If the new and current value differ, record the change.
            if (!_.isEqual(now[attr], val) || (options.unset && _.has(now, attr))) {
                delete escaped[attr];
                (options.silent ? this._silent : changes)[attr] = true;
            }

            // Update or delete the current value.
            var subdoc = this.doc.at(attr);
            if (options.unset) {
                subdoc.remove();
            }
            else {
                subdoc.set(val);
            }

            // If the new and previous value differ, record the change.  If not,
            // then remove changes for this attribute.
            if (!_.isEqual(prev[attr], val) || (_.has(now, attr) != _.has(prev, attr))) {
                this.changed[attr] = val;
                if (!options.silent) this._pending[attr] = true;
            } else {
                delete this.changed[attr];
                delete this._pending[attr];
            }
        }

        // Fire the `"change"` events.
        if (!options.silent) this.change(options);
        return this;
    },

    clear: function (options) {
        (options || (options = {})).unset = true;
        return this.set(_.clone(this.doc.get()), options);
    },

    destroy: function (options) {
        // TODO
    },

    clone: function () {
        return new this.constructor(this.doc.get());
    },

    isValid: function() {
        return !this.validate(this.doc.get());
    },

    _validate: function(attrs, options) {
        if (options.silent || !this.validate) return true;
        attrs = _.extend({}, this.doc.get(), attrs);
        var error = this.validate(attrs, options);
        if (!error) return true;
        if (options && options.error) {
            options.error(this, error, options);
        } else {
            this.trigger('error', this, error, options);
        }
        return false;
    }

});
