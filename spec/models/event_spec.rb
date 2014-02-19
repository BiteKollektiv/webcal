require 'spec_helper'

describe Event do
  before :each do
    @event = build(:event)
  end

  # "respond_to" attr specs
  it { should respond_to(:title) }
  it { should respond_to(:description) }
  it { should respond_to(:location) }
  it { should respond_to(:starts_at) }
  it { should respond_to(:ends_at) }
  it { should respond_to(:calendar) }
  it { should respond_to(:created_at) }
  it { should respond_to(:updated_at) }


  # "respond_to" method specs
  it { should respond_to(:duration) }
  it { should respond_to(:tags) }

  # "validate" specs
  it { expect(@event).to be_valid }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:starts_at) }
  it { should validate_presence_of(:ends_at) }
  it { should belong_to(:calendar) }

  # relation specs
  it { should have_many(:tags) }


  it "should be invalid without a calendar" do
    @event.calendar = nil
    expect(@event).to be_invalid
  end

  it "should have a duration" do
    expected_duration = 4*60*60

    @event.starts_at = DateTime.new(2011, 1, 1, 10, 0, 0)
    @event.ends_at   = DateTime.new(2011, 1, 1, 14, 0, 0)

    expect(@event.duration).to eq expected_duration
  end

  it "should be able to have zero tags" do
    @event.tags.delete @event.tags
    expect(@event.tags).to be_empty
  end

  it "should be able to have one tag" do
    @event.tags.delete @event.tags
    @event.tag_names << 'film'
    @event.save
    expect(@event.tag_names).to eq ['film']
  end

  it "should be able to have more than one tag" do
    @event.tags.delete @event.tags
    @event.tag_names << 'film'
    @event.tag_names << 'discussion'
    @event.save
    expect(@event.tag_names).to eq ['film', 'discussion']
  end
end
