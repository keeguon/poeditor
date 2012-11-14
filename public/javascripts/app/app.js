(function() {

  var App;

  App = (function() {

    function App() {}

    App.prototype.start = function() {
      new LocalesRouter;
      Backbone.history.start({ pushState: true });
    }

    return App;

  })();

  this.App = App;

}).call(this);