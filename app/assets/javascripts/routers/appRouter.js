SimpleShortner.appRouter = Backbone.Router.extend({
  routes: {
    "":"newShortlinkView",
    "show":"success"
  },

  initialize: function (options) {
    this.$rootEl = options.$rootEl
  },

  newShortlinkView: function () {
    var linkForm = new SimpleShortner.Views.newShortlinkView();
    this._swapView(linkForm);
  },

  success: function (options) {
    var success = new SimpleShortner.Views.showShortlinkView(options);
    this._swapView(success)
  },

  _swapView: function (newView) {
    this.$rootEl.html(newView.render().$el);
    this._currentView && this._currentView.remove();
    this._currentView = newView;
  }
})