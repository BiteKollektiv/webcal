$(function() {
  var CalendarApp = Backbone.View.extend({
    el: $('#wrap'),

      initialize: function(){
        this.headerModel = new HeaderModel();
        this.headerView = new HeaderView({
          model: this.headerModel,
          el: $('header')
        });
        this.headerModel.fetch();

        this.eventsView = new EventsView({
          el: $("#calendarView"),
          collection: events
        }).render();

        this.events.fetch();
      }
  });

  var calendar = new CalendarApp;

});
