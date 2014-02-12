require 'spec_helper'

describe Calendar do
  before :each do
    @calendar = create(:calendar)
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
  it { expect(@calendar).to be_valid }
  it { should validate_presence_of(:token_read) }
  it { should validate_presence_of(:token_write) }
  it { should validate_uniqueness_of(:token_read) }
  it { should validate_uniqueness_of(:token_write) }
  it { should have_many(:events) }

  it "should be invalid without a read_token" do
    @calendar.token_read = nil
    expect(@calendar).to be_invalid
  end

  it "should be invalid without a write token" do
    @calendar.token_write = nil
    expect(@calendar).to be_invalid
  end

  it "should return a list of events for this month"
  it "should return a list of events for this week"
  it "should return a list of events for today"
end
