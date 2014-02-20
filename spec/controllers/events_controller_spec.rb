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

  describe "POST create event" do
    it "checks events create route" do
      calendar = Calendar.create! valid_calendar_attributes
      calendar_id = calendar.token_read
      assert_recognizes({ controller: 'events', action: 'create', calendar_id: calendar_id, locale: 'en'}, {path:"/en/calendars/#{calendar_id}/events", method: :post})
    end
  end

  describe "PUT update event" do
    it "checks events update route" do
      calendar = Calendar.create! valid_calendar_attributes
      calendar_id = calendar.token_read
      assert_recognizes({ controller: 'events', action: 'update', calendar_id: calendar_id, locale: 'en', id: '1'}, {path:"/en/calendars/#{calendar_id}/events/1", method: :put})
    end
  end

  describe "DELETE an event" do
    it "checks the deletion of an event" do
      calendar = Calendar.create! valid_calendar_attributes
      calendar_id = calendar.token_read
      assert_recognizes({ controller: 'events', action: 'destroy', calendar_id: calendar_id, locale: 'en', id: '1'}, {path:"/en/calendars/#{calendar_id}/events/1", method: :delete})
    end
  end
end
