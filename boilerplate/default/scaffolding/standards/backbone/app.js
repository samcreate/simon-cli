var App = new(Backbone.Router.extend({
    routes: {
        "": "index"
    },
    initialize: function () {

    },
    index: function () {
        this.todoList.fetch();
    },
    start: function () {
        Backbone.history.start({
            pushState: true
        });
    }
}));