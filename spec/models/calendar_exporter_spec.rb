require 'spec_helper'

describe CalendarExporter do
  describe "#export" do
    before :each do
      @calendar = create(:calendar_with_events_with_tags)
      @exporter = CalendarExporter.new(@calendar, &CalendarExporter::ICAL_FORMATTER)
    end

    it "should return the path to the saved .ical file" do
      expect(@exporter.export).to match /[\w_=-]*.ics/
    end
  end
end
