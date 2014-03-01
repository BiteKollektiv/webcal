$(function() {
	var CalendarView = Backbone.View.extend({
		el: $('#wrap'),

		initialize: function(){
			this.headerView = new HeaderView({
				model: HeaderModel,
				el: $('header')
			});
			this.monthView = new MonthView({
				el: $("#calendarView")
			})
		}
	});

	calendarView = new CalendarView;


});