// $(function() {
//   var CalendarApp = Backbone.View.extend({
//     el: $('#wrap'),
//
//       initialize: function(){
//         this.headerModel = new HeaderModel();
//         this.headerView = new HeaderView({
//           model: this.headerModel,
//           el: $('header')
//         });
//         this.headerModel.fetch();
//
//         this.eventsView = new EventsView({
//           el: $("#calendarView"),
//           collection: events
//         }).render();
//
//         this.events.fetch();
//       }
//   });
//
//   var calendar = new CalendarApp;
//
// });
window.WebcalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function(data) {
    // this.tasks = new WebcalApp.Collections.Tasks(data.tasks);
    // this.users = new WebcalApp.Collections.Users(data.users);

    new WebcalApp.Routers.Calendars({ });
    if (!Backbone.history.started) {
      Backbone.history.start();
      Backbone.history.started = true;
    }
  }
};
$(function () {
  WebcalApp.initialize({});
});
