
goog.provide('nujii.studio.models.Region');

goog.require('backbone');

nujii.studio.models.Region = Backbone.Model.extend({

    // Default attributes
    defaults: function() {
        return {
            title: "Untitled Region",
            levels: null,
            start: 0.0,
            duration: 0.0,
            offset: 0.0,
            isRecording: false,
            isLoading: false
        };
    }

});

