var MonthView = Backbone.View.extend({
	template: HandlebarsTemplates["monthView"],

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(this.template);
		return this;
	}


});