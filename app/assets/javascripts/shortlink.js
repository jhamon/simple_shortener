SimpleShortner = {
  Models: {},
  Collections: {},
  Views: {},
  initialize: function () {
    SimpleShortner.router = new SimpleShortner.appRouter({
      $rootEl: $('.inner.cover')
    })
    
    SimpleShortner.shortlinks = new SimpleShortner.Collections.shortlinks();
    Backbone.history.start({pushState: true});
    SimpleShortner.router.navigate("", {trigger: true});
  }
}

$(document).ready(function () {
  SimpleShortner.initialize();
})


