require 'spec_helper'

describe Calendar do
  before :each do
    @calendar = build(:calendar)
  end

  # Using should here, because it reads easier
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:token_read) }
  it { should respond_to(:token_write) }
  it { should respond_to(:events) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }

  # Validation specs
  it { should callback(:generate_read_token).before(:validation) }
  it { should callback(:generate_write_token).before(:validation) }
  it { should have_many(:events) }

  it "sets the read and write tokens" do
    @calendar = create(:calendar)
    expect(@calendar.token_read).not_to be_nil
    expect(@calendar.token_write).not_to be_nil
  end

  it "should return a list of events for this month"
  it "should return a list of events for this week"

  it "should return a list of events for today" do
    @event_yesterday = create(:event,
                              starts_at: 2.days.ago,
                              ends_at: 1.day.ago,
                              calendar: @calendar)
    @event_today = create(:event,
                          starts_at: DateTime.now,
                          ends_at: DateTime.now + 5.minutes,
                         calendar: @calendar)
    @event_tomorrow = create(:event,
                             starts_at: DateTime.tomorrow,
                             ends_at: DateTime.tomorrow + 5.minutes,
                            calendar: @calendar)
    expect(@calendar.today).to include(@event_today)
    expect(@calendar.today).not_to include(@event_tomorrow)
    expect(@calendar.today).not_to include(@event_yesterday)

  end
end
