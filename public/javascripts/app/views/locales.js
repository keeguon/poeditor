(function() {

  var LocalesView;

  LocalesView = (function(_super) {

    __extends(LocalesView, _super);

    LocalesView.prototype.el = $("#locales");

    function LocalesView() {
      LocalesView.__super__.constructor.apply(this, arguments);

      // Initialize locales
      this.locales = new Locales;
      this.locales.on('reset', this.addAll, this);
    }

    LocalesView.prototype.render = function() {
      var that;

      that = this;

      // Create data object to query locales
      this.data = {
        filter: this.options.filter || "locale",
        locale: this.options.locale,
        limit:  this.options.limit || 25,
        page:   this.options.page || 1
      }
      if (typeof this.options.fuzzy === "boolean") {
        this.data.fuzzy = this.options.fuzzy;
      } else if (typeof this.options.fuzzy === "string") {
        this.data.fuzzy = !!this.options.fuzzy.search(/(t|1|true|on)/i);
      } else {
        delete(this.data.fuzzy);
      }
      if (typeof this.options.obsolete === "boolean") {
        this.data.obsolete = this.options.obsolete;
      } else {
        delete(this.data.obsolete);
      }

      // Empty any existing content
      $(this.el).empty();

      // Fetch locales
      this.locales.fetch({ data: this.data });

      return this;
    };

    LocalesView.prototype.addOne = function(locale) {
      var view = new LocaleView({ model: locale });
      $(this.el).append(view.render().el);
    };

    LocalesView.prototype.addAll = function() {
      var that;

      that = this;

      // Create views
      this.locales.each(this.addOne, this);

      // Infinite scrolling :)
      $(this.el).find("tr").last().waypoint(function(event, direction) {
        $(that.el).find("tr").last().waypoint("remove");
        if (direction === "down") {
          that.loadMore();
        }
      }, { offset: '100%' });
    };

    LocalesView.prototype.loadMore = function(callback) {
      var req;

      // Increase page
      this.data.page = this.data.page + 1;

      // Fetch locales
      req = this.locales.fetch({ data: this.data });
      req.done(callback)

      return this;
    };

    return LocalesView;

  })(Backbone.View);

  this.LocalesView = LocalesView;

}).call(this);