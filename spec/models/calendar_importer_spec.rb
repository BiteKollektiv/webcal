require 'spec_helper'

describe CalendarImporter do
  def calendar_fixture_file
    fixture_file = Rails.root.join('spec', 'fixtures', 'calendars', 'two_events.ics')
    opts = {type: "text/calendar",
            tempfile: fixture_file,
            filename: fixture_file.basename.to_s
    }
    ActionDispatch::Http::UploadedFile.new(opts)
  end

  describe "when file has 2 events in 1 calendar" do
    before :all do
      @calendar = create(:calendar)
      @uploaded_file = Uploader.upload(calendar_fixture_file, ["text/calendar"])
    end

    it "should add 2 events to the calendar" do
      importer = CalendarImporter.new(@calendar, @uploaded_file)
      expect{importer.import}.
        to change{@calendar.events.size}.from(0).to(2)
    end
  end

  describe "when file has multiple events in multiple calendars" do
    it "should assign tags to events for each subcalendar"
  end
end
