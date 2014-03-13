WebcalApp.Routers.Calendars = Backbone.Router.extend({
  initialize: function(options) {
    this.el = $('#wrap');
  },

  routes: {
    "calendars/:token": "showCalendar",
    "": "newCalendar"
  },

  initialize: function(options) {
    this.events = new WebcalApp.Collections.Events();
  },

  showCalendar: function(token) {
    calendarView = new WebcalApp.Views.CalendarView({
      el: $("#calendarView"),
      collection: events
    });
    calendarView.render();
  },

  newCalendar: function() {
    createCalendarView = new WebcalApp.Views.CalendarsCreate({
      el: $("#wrap"),
      collection: this.events
    });
    createCalendarView.render();
  }
});
