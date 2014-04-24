SimpleShortner.Views.showShortlinkView = Backbone.View.extend({
  template: JST['showShortlinkView'],

  events: {
    'click .another':'navigateHome'
  },

  render: function () {
    this.$el.html(this.template({code: SimpleShortner.shortlinks.last()}));
    return this;
  },

  navigateHome: function () {
    SimpleShortner.router.navigate("", {trigger: true});
  }
})