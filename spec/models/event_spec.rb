require 'spec_helper'

describe Event do
  before :each do
    @event = create(:event)
  end

  it { expect(@event).to respond_to(:title) }
  it { expect(@event).to respond_to(:description) }
  it { expect(@event).to respond_to(:location) }
  it { expect(@event).to respond_to(:starts_at) }
  it { expect(@event).to respond_to(:ends_at) }
  it { expect(@event).to respond_to(:calendar) }
  it { expect(@event).to respond_to(:created_at) }
  it { expect(@event).to respond_to(:updated_at) }

  it "should be valid" do
    pending "Need to add validations to event model"
    # expect(@event).to be_valid
  end

  it "should be invalid without a start date"
  it "should be invalid without an end date"
  it "should be invalid without a calendar"
  it "should have a duration"
end
