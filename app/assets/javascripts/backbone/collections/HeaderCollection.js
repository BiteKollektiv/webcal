var HeaderCollection = Backbone.Collection.extend({
	model: HeaderModel,
	url: '/app/assets/javascript/backbone/calendarDetail.json'
});

var calendarInfo = new HeaderCollection();
calendarInfo.fetch();
console.log(calendarInfo);