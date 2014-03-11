require 'spec_helper'

describe EventsController do
  let(:valid_calendar_attributes) { { title: "test", description: "a longer text"} }
  let(:valid_event_attributes) { { title: "test", description: "a longer text", location: "Some place", starts_at: DateTime.now, ends_at: DateTime.now, calendar_id: 1} }

  describe "GET index" do
    it "checks events index route" do
      calendar = Calendar.create! valid_calendar_attributes
      calendar_id = calendar.token_read
      assert_recognizes({ controller: 'events', action: 'index', calendar_id: calendar_id, locale: 'en'}, "/en/calendars/#{calendar_id}/events")
    end
  end

  describe "GET new" do
    it "checks Event's new route" do
      calendar = Calendar.create! valid_calendar_attributes
      calendar_id = calendar.token_read
      assert_recognizes({ controller: 'events', action: 'new', calendar_id: calendar_id, locale: 'en'}, {path:"/en/calendars/#{calendar_id}/events/new", method: :get})
    end
  end

  describe "POST create" do
    it "checks Event's create route" do
      calendar = Calendar.create! valid_calendar_attributes
      calendar_id = calendar.token_read
      assert_recognizes({ controller: 'events', action: 'create', calendar_id: calendar_id, locale: 'en'}, {path:"/en/calendars/#{calendar_id}/events", method: :post})
    end
  end

  describe "GET edit" do
    it "checks Event's edit route" do
      calendar = Calendar.create! valid_calendar_attributes
      calendar_id = calendar.token_read
      assert_recognizes({ controller: 'events', action: 'edit', calendar_id: calendar_id, locale: 'en', id: '1'}, {path:"/en/calendars/#{calendar_id}/events/1/edit", method: :get})
    end
  end

  describe "PATCH update" do
    it "checks Event's update route" do
      calendar = Calendar.create! valid_calendar_attributes
      calendar_id = calendar.token_read
      assert_recognizes({ controller: 'events', action: 'update', calendar_id: calendar_id, locale: 'en', id: '1'}, {path:"/en/calendars/#{calendar_id}/events/1", method: :patch})
    end
  end

  describe "DELETE an event" do
    it "checks the delete route" do
      calendar = Calendar.create! valid_calendar_attributes
      calendar_id = calendar.token_read
      assert_recognizes({ controller: 'events', action: 'destroy', calendar_id: calendar_id, locale: 'en', id: '1'}, {path:"/en/calendars/#{calendar_id}/events/1", method: :delete})
    end
  end
end
