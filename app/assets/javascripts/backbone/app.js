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

			this.monthView = new MonthView({
				el: $("#calendarView")
			})
		}
	});

	var calendar = new CalendarApp;

});