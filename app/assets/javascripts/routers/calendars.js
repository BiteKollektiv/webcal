WebcalApp.Routers.Calendars = Backbone.Router.extend({
  initialize: function(options) {
    this.el = $('#wrap');
  },

  routes: {
    "show": "showCalendar",
    "": "newCalendar"
  },

  showCalendar: function(token) {
    console.log(token);
    eventsView = new WebcalApp.Views.EventsView({
      el: $("#calendarView"),
      collection: events
    });
    eventsView.render();
    console.log(eventsView);
  },

  newCalendar: function() {
    console.log("Create calendar function called");
  }
});
