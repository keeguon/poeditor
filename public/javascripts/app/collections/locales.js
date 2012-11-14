(function() {

  var Locales;

  Locales = (function(_super) {

    __extends(Locales, _super);

    function Locales() {
      Locales.__super__.constructor.apply(this, arguments);
      this.model = Locale;
      this.url   = "/locales";
    }

    return Locales;

  })(Backbone.Collection);

  this.Locales = Locales;

}).call(this);