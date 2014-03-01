var HeaderView = Backbone.View.extend({
	template: HandlebarsTemplates["header"],

	initialize: function(){
		this.render();
	},

	render: function(){
		this.$el.html(this.template);
		return this;
	}
});