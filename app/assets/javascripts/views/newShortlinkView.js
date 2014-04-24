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
    var data = this.$('form').serializeJSON();
    var newlink = new SimpleShortner.Models.shortlink(data);
    newlink.save([], {
      success: function () {
        SimpleShortner.shortlinks.add(newlink);
        SimpleShortner.router.navigate('show', {trigger: true});
      }, 
      error: function () {
        // display error message
        alert('Oops!');
      }
    });
  }
});