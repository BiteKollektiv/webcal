var Events = Backbone.Collection.extend({
	model: Event,
	url: "events"
});

var events = new Events();