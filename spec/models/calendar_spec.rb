require 'spec_helper'

describe Calendar do
  before :each do
    @calendar = create(:calendar)
  end

  it { expect(@calendar).to respond_to(:title) }
  it { expect(@calendar).to respond_to(:description) }
  it { expect(@calendar).to respond_to(:token_read) }
  it { expect(@calendar).to respond_to(:token_write) }
  it { expect(@calendar).to respond_to(:events) }
  it { expect(@calendar).to respond_to(:created_at) }
  it { expect(@calendar).to respond_to(:updated_at) }

  it "should be valid" do
    pending "Need to add validations to calendar model"
    # expect(@calendar).to be_valid
  end

  it "should be invalid without a read_token"
  it "should be invalid without a write token"
  it "should return a list of events for this month"
  it "should return a list of events for this week"
  it "should return a list of events for today"
end
