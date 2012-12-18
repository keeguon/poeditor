(function() {

  var Locale;

  Locale = (function(_super) {

    __extends(Locale, _super);

    function Locale() {
      Locale.__super__.constructor.apply(this, arguments);
      this.urlRoot = "/locales";
    }

    Locale.prototype.isFuzzy = function() {
      return /fuzzy\n$/.test(this.get('comment'));
    };

    return Locale;

  })(Backbone.Model);

  this.Locale = Locale;

}).call(this);