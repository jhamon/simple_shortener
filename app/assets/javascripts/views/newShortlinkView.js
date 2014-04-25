SimpleShortner.Views.newShortlinkView = Backbone.View.extend({
  info: 'view:newShortlinkView',

  events: {
    'click .make-link':'sendLink'
  },

  template: JST['newShortlinkView'],

  render: function () {
    this.$el.html(this.template());
    return this;
  },

  sendLink: function (e) {
    e.preventDefault();
    var view = this;
    var data = this.$('form').serializeJSON();
    var newlink = new SimpleShortner.Models.shortlink(data);
    newlink.save([], {
      success: function () {
        SimpleShortner.shortlinks.add(newlink);
        SimpleShortner.router.navigate('show', {trigger: true});
      }, 
      error: function () {
        view.displayError();
      }
    });
  },

  displayError: function () {
    this.$('.errors').append(this.errorAlert("There was a problem creating your shortlink."));
  },

  errorAlert: function (msg) {
    var $errorAlert = $("<div></div>", {class: "alert alert-danger alert-dismissable", text: msg});
    var $close =  $("<button>", {type: "button", class: "close", "data-dismiss": "alert", "aria-hidden": true}).html("&times;");

    $errorAlert.append($close);

    // Animations.
    $errorAlert.hide();
    window.setTimeout(function () { $errorAlert.slideToggle("fast"); }, 200);

    return $errorAlert;
  }
});