(function() {

  var LocaleView;

  LocaleView = (function(_super) {

    __extends(LocaleView, _super);

    LocaleView.prototype.tagName = "tr";

    LocaleView.prototype.template = new EJS({ url: "javascripts/app/templates/locale.ejs" });

    LocaleView.prototype.events = {
      "click .edit":    "edit",
      "click .destroy": "clear"
    };

    function LocaleView() {
      LocalesView.__super__.constructor.apply(this, arguments);

      // Bind model events
      this.model.on('change', this.render, this);
      this.model.on('remove', this.remove, this);
    }

    LocaleView.prototype.render = function() {
      $(this.el).html(this.template.render(this.model.toJSON()));

      return this;
    };

    LocaleView.prototype.edit = function() {
      var view = new LocaleDialogView({ model: this.model });
      view.render();

      return this;
    };

    LocaleView.prototype.clear = function() {
      this.model.destroy();

      return this;
    };

    return LocaleView;

  })(Backbone.View);

  this.LocaleView = LocaleView;

}).call(this);