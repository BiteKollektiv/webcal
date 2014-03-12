WebcalApp.Views.EventsView = Backbone.View.extend({
  collection: events,

    initialize: function(){
      _.bindAll(this, 'addAll');

      this.collection.bind('reset', this.addAll);
    },

    render: function(){
      this.$el.fullCalendar({
        header: {
          left: 'prev,next today',
      center: 'title',
      right: 'month,basicWeek,basicDay',
      ignoreTimezone: false
        },
      selectable: true,
      selectHelper: true,
      editable: true
      });
    },

    addAll: function(){
      this.$el.fullCalendar ("addEventSource", this.collection.toJSON());
    }
});
