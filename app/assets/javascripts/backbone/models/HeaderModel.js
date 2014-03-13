var HeaderModel = Backbone.Model.extend({
  isEdit: false,
    url: '/assets/calendarDetail.json'
});

headerModel = new HeaderModel();
headerModel.fetch();
