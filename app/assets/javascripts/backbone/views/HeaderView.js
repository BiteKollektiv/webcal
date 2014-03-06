var HeaderView = Backbone.View.extend({
	template: HandlebarsTemplates["header"],
	model: headerModel,

	initialize: function(){
		this.render();
		this.model.on('change', this.render, this);
	},

	render: function(){
		this.$el.html(this.template(this.model.toJSON()));
		return this;
	}
});
