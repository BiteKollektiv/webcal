require 'spec_helper'

describe Event do
  before :each do
    @event = build(:event)
  end

  # "respond_to" specs
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:location) }
  it { should respond_to(:starts_at) }
  it { should respond_to(:ends_at) }
  it { should respond_to(:calendar) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }

  # "validate" specs
  it { expect(@event).to be_valid }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:starts_at) }
  it { should validate_presence_of(:ends_at) }
  it { should belong_to(:calendar) }

  it "should be invalid without a calendar" do
    @event.calendar = nil
    expect(@event).to be_invalid
  end

  it "should have a duration"
end
