(function() {

  var Locale;

  Locale = (function(_super) {

    __extends(Locale, _super);

    function Locale() {
      Locale.__super__.constructor.apply(this, arguments);
      this.urlRoot = "/locales";
    }

    return Locale;

  })(Backbone.Model);

  this.Locale = Locale;

}).call(this);