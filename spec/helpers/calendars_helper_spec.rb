require 'spec_helper'

describe CalendarsHelper do
  before :all do
    Timecop.freeze(DateTime.new(2013, 07, 11, 20, 22, 13))
  end

  before :each do
    @calendar = FactoryGirl.create(:calendar)
  end

  after :all do
    Timecop.return
  end

  describe "#direction_link_params" do
    before :all do
      @date = DateTime.now
    end

    it "should set the right token for a changeable calendar" do
      @calendar.writable = true
      @type = :day
      expect(direction_link_params(:back)[:id]).to eq(@calendar.token_write)
    end

    it "should set the right token for an unchangeable calendar" do
      @calendar.writable = false
      @type = :day
      expect(direction_link_params(:back)[:id]).to eq(@calendar.token_read)
    end

    context "in the daily view" do
      before :all do
        @type = :day
      end

      it "should set the correct forward link" do
        options_hash = {controller: "calendars", action: "show",
                        id: @calendar.token_read,
                        date: @date.next_day.strftime("%Y-%m-%d"), type: @type}
        expect(direction_link_params(:forward)).to eq(options_hash)
      end

      it "should set the correct backward link" do
        options_hash = {controller: "calendars", action: "show",
                        id: @calendar.token_read,
                        date: @date.prev_day.strftime("%Y-%m-%d"), type: @type}
        expect(direction_link_params(:back)).to eq(options_hash)
      end
    end

    context "in the weekly view" do
      before :all do
        @type = :week
      end

      it "should set the correct forward link" do
        options_hash = {controller: "calendars", action: "show",
                        id: @calendar.token_read,
                        date: @date.next_week.strftime("%Y-%m-%d"), type: @type}
        expect(direction_link_params(:forward)).to eq(options_hash)
      end

      it "should set the correct backward link" do
        options_hash = {controller: "calendars", action: "show",
                        id: @calendar.token_read,
                        date: @date.prev_week.strftime("%Y-%m-%d"), type: @type}
        expect(direction_link_params(:back)).to eq(options_hash)
      end
    end

    context "in the monthly view" do
      before :all do
        @type = :month
      end

      it "should set the correct forward link" do
        options_hash = {controller: "calendars", action: "show",
                        id: @calendar.token_read,
                        date: @date.next_month.beginning_of_month.strftime("%Y-%m-%d"), type: @type}
        expect(direction_link_params(:forward)).to eq(options_hash)
      end

      it "should set the correct backward link" do
        options_hash = {controller: "calendars", action: "show",
                        id: @calendar.token_read,
                        date: @date.prev_month.beginning_of_month.strftime("%Y-%m-%d"), type: @type}
        expect(direction_link_params(:back)).to eq(options_hash)
      end
    end
  end

  describe "#type_link_params" do
    it "should return the correct hash" do
      @date = DateTime.now
      link_hash = {date: @date, type: :week}
      expect(type_link_params(:week)).to eq(link_hash)
    end
  end
end
