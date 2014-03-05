require 'spec_helper'

describe CalendarExporter do
  describe "#export" do
    before :each do
      @calendar = create(:calendar)
      @exporter = CalendarExporter.new(@calendar, &ICAL_FORMATTER)
    end

    it "should return the path to the saved .ical file" do
      expect(@exporter.export).to match /[\w_=-]*.ics/
    end
  end
end
