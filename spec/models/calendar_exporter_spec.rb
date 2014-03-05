require 'spec_helper'

describe CalendarExporter do
  before :each do
    @calendar = create(:calendar)
    @exporter = CalendarExporter.new(@calendar, &ICAL_FORMATTER)
  end

  it "should return a Icalendar::Calendar" do
    expect(@exporter.export).to be_a(Icalendar::Calendar)
  end

  context "with 2 events" do
    before :each do
      @calendar = create(:calendar_with_events)
      @exporter = CalendarExporter.new(@calendar, &ICAL_FORMATTER)
    end

    it "should contain 2 events" do
      icalendar = @exporter.export
      expect(icalendar.events.size).to be 2
    end
  end
end
