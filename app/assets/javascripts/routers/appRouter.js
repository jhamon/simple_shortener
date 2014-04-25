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
    // Append as hidden
    newView.render();
    this.$rootEl.append(newView.render().$el.hide());

    this._currentView && this._currentView.$el.fadeOut(800);
    newView.$el.fadeIn(800);
    
    this._currentView && this._currentView.remove();
    this._currentView = newView;
  }
})