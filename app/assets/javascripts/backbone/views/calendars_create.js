WebcalApp.Views.CalendarsCreate = Backbone.View.extend({
  template: HandlebarsTemplates["calendars_create"],

  events: {
    "submit #new_calendar": "save"
  },

  render: function() {
    this.$el.html(this.template);
    return this;
  },

  save: function(e) {
    console.log("save called");
    e.preventDefault();
    e.stopPropagation();
    model = new WebcalApp.Models.Calendar();
    this.collection.create(model, {
      success: (function(_this) {
        return function(calendar) {};
      })(this)
    });
    this.model = calendar;
    return window.location.hash = "/" + this.model.id;
  }
});
