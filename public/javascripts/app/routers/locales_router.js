(function() {

  var LocalesRouter;

  LocalesRouter = (function(_super) {

    __extends(LocalesRouter, _super);

    LocalesRouter.prototype.routes = {
      "locales":               "index",
      "locales/import_review": "importReview"
    };

    function LocalesRouter() {
      LocalesRouter.__super__.constructor.apply(this, arguments);
    }

    LocalesRouter.prototype.index = function(params) {
      var view = new LocalesTabsView({ params: params });
    };

    LocalesRouter.prototype.importReview = function(params) {
      var view = new LocalesImportReviewView({ params: params });
    };

    return LocalesRouter;

  })(Backbone.Router);

  this.LocalesRouter = LocalesRouter;

}).call(this);