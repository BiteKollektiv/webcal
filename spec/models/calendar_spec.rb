require 'spec_helper'

describe Calendar do
  before :each do
    @calendar = build(:calendar)
  end

  before :all do
    Timecop.freeze(DateTime.new(2013, 07, 11, 20, 22, 13))
  end

  after :all do
    Timecop.return
  end

  # Using should here, because it reads easier
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:token_read) }
  it { should respond_to(:token_write) }
  it { should respond_to(:events) }
  it { should respond_to(:month) }
  it { should respond_to(:week) }
  it { should respond_to(:today) }
  it { should respond_to(:writable?) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }
  it { should respond_to(:import) }
  it { should respond_to(:to_ical) }

  # Validation specs
  it { should callback(:generate_token).before(:validation) }
  it { should ensure_length_of(:title).is_at_least(2).is_at_most(140) }
  it { should ensure_length_of(:description).is_at_least(10).is_at_most(3000) }
  it { should have_many(:events) }

  it "sets the read and write tokens" do
    @calendar = create(:calendar)
    expect(@calendar.token_read).not_to be_nil
    expect(@calendar.token_write).not_to be_nil
  end

  describe ".find_by_token" do
    before :each do
      @calendar = create(:calendar)
    end

    it "sets writable? to false, if token_write is 13 chars long" do
      calendar= Calendar.set_permissions(@calendar.token_read)
      expect(calendar.writable?).to be_false
    end

    it "sets writable? to true, if token_write is found" do
      calendar= Calendar.set_permissions(@calendar.token_write)
      expect(calendar.writable?).to be_true
    end
  end

  describe "#import" do
    before :all do
      fixture_file = Rails.root.join('spec', 'fixtures', 'calendars', 'no_events.ics')
      opts = {type: "text/calendar",
              tempfile: fixture_file,
              filename: fixture_file.basename.to_s
      }
      local_file = ActionDispatch::Http::UploadedFile.new(opts)
      @uploaded_file = Uploader.upload(local_file, ["text/calendar"])
    end
  end

  describe "#month" do
    it "should include events on Monday of the first week of the month" do
      event_start = Time.zone.now.beginning_of_month.beginning_of_week
      event_end = event_start + 1.hour

      @event = create(:event,
                        starts_at: event_start,
                        ends_at: event_end,
                        calendar: @calendar)

      expect(@calendar.month).to include(@event)
    end

    it "should include events on Friday of the last week of the month" do
      event_start = Time.zone.now.end_of_month.end_of_week - 10.hours
      event_end = event_start + 1.hour

      @event = create(:event,
                        starts_at: event_start,
                        ends_at: event_end,
                        calendar: @calendar)

      expect(@calendar.month).to include(@event)
    end

    it "should not include events from other months" do
      @event_before = create(:event,
                             starts_at: 2.months.ago,
                             ends_at: 2.months.ago + 1.hour,
                             calendar: @calendar)
      @event_after= create(:event,
                           starts_at: Time.zone.now + 2.months,
                           ends_at: Time.zone.now + 2.months + 1.day,
                             calendar: @calendar)

      expect(@calendar.month).not_to include(@event_before)
      expect(@calendar.month).not_to include(@event_after)
    end
  end

  describe "#week" do
    it "should return a list of events for this week" do
      event_start = Time.zone.now.beginning_of_week
      event_end = event_start + 1.hour

      @event = create(:event,
                        starts_at: event_start,
                        ends_at: event_end,
                        calendar: @calendar)

      expect(@calendar.week).to include(@event)
    end

    it "should not include events from other weeks" do
      @event_before = create(:event,
                             starts_at: 2.months.ago,
                             ends_at: 2.months.ago + 1.hour,
                             calendar: @calendar)
      @event_after= create(:event,
                           starts_at: Time.zone.now + 2.months,
                           ends_at: Time.zone.now + 2.months + 1.day,
                           calendar: @calendar)

      expect(@calendar.week).not_to include(@event_before)
      expect(@calendar.week).not_to include(@event_after)
    end
  end

  describe "#today" do
    it "should return a list of events for today" do
      @event_before = create(:event,
                                starts_at: 2.days.ago,
                                ends_at: 1.day.ago,
                                calendar: @calendar)
      @event_inside = create(:event,
                            starts_at: DateTime.now,
                            ends_at: DateTime.now + 5.minutes,
                           calendar: @calendar)
      @event_after = create(:event,
                               starts_at: DateTime.tomorrow,
                               ends_at: DateTime.tomorrow + 5.minutes)
      expect(@calendar.today).to include(@event_inside)
      expect(@calendar.today).not_to include(@event_before)
      expect(@calendar.today).not_to include(@event_after)
    end
  end

  describe "#events_by_date" do
    it "should return events only for the specified date" do
      @event_before = create(:event,
                                starts_at: 2.days.ago,
                                ends_at: 1.day.ago,
                                calendar: @calendar)
      @event_inside = create(:event,
                             starts_at: Time.zone.now.beginning_of_day,
                             ends_at: Time.zone.now.beginning_of_day + 4.minutes,
                           calendar: @calendar)
      @event_after = create(:event,
                            starts_at: Time.zone.now.tomorrow,
                            ends_at: Time.zone.now.tomorrow + 5.minutes,
                              calendar: @calendar)

      expect(@calendar.today).to include(@event_inside)
      expect(@calendar.today).not_to include(@event_before)
      expect(@calendar.today).not_to include(@event_after)
    end
  end
end
