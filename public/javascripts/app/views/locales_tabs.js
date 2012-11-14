(function() {

  var LocalesTabsView;

  LocalesTabsView = (function(_super) {

    __extends(LocalesTabsView, _super);

    LocalesTabsView.prototype.events = {
      "click li a": "switchTab"
    };

    LocalesTabsView.prototype.el = $("#locales-tabs");

    function LocalesTabsView() {
      LocalesTabsView.__super__.constructor.apply(this, arguments);

      // Retrieve some elements
      this.$lis = $(this.el).find("li");

      // Initialize LocalesView
      this.localesView = new LocalesView(this.options.params);
      this.localesView.render();
    }

    LocalesTabsView.prototype.switchTab = function(event) {
      var $li;

      event.preventDefault();

      // Deactivate all tabs
      this.$lis.removeClass("active");

      // Activate clicked tab
      $li = $(event.target).parent();
      $li.addClass("active");

      // Reload locales
      this.localesView.options = _.extend(this.localesView.options, $(event.target).data());
      this.localesView.render();

      return this;
    };

    return LocalesTabsView;

  })(Backbone.View);

  this.LocalesTabsView = LocalesTabsView;

}).call(this);