(function() {

  var LocaleDialogView;

  LocaleDialogView = (function(_super) {

    __extends(LocaleDialogView, _super);

    LocaleDialogView.prototype.tagName = "div";

    LocaleDialogView.prototype.className = "modal hide fade"

    LocaleDialogView.prototype.template = new EJS({ url: "/javascripts/app/templates/locale_dialog.ejs" });

    LocaleDialogView.prototype.events = {
      "click .save":   "save",
      "click .cancel": "cancel"
    };

    function LocaleDialogView() {
      LocaleDialogView.__super__.constructor.apply(this, arguments);
    }

    LocaleDialogView.prototype.render = function() {
      var that;

      that = this;

      $(this.el).append(this.template.render({ locale: this.model }));

      $("body").append($(this.el));
      this.$modal = $(this.el).modal();
      this.$modal.on('hidden', function() {
        that.remove();
      });

      return this;
    };

    LocaleDialogView.prototype.save = function(event) {
      var req, that;

      event.preventDefault();

      that = this;

      // Update model
      this.model.set($(this.el).find("form").serializeObject());
      req = this.model.save();
      req.done(function() { that.$modal.modal("hide"); });

      return this;
    };

    LocaleDialogView.prototype.cancel = function(event) {
      event.preventDefault();

      this.$modal.modal("hide");

      return this;
    };

    return LocaleDialogView;

  })(Backbone.View);

  this.LocaleDialogView = LocaleDialogView;

}).call(this);