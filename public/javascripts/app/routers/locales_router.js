(function() {

  var LocalesRouter;

  LocalesRouter = (function(_super) {

    __extends(LocalesRouter, _super);

    LocalesRouter.prototype.routes = {
      "locales": "index"
    };

    function LocalesRouter() {
      LocalesRouter.__super__.constructor.apply(this, arguments);
    }

    LocalesRouter.prototype.index = function(params) {
      var view = new LocalesTabsView({ params: params });
    }

    return LocalesRouter;

  })(Backbone.Router);

  this.LocalesRouter = LocalesRouter;

}).call(this);