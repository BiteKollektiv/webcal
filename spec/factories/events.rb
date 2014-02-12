FactoryGirl.define do
  factory :event do
    title "Test Title"
    description "Test Description"
    location "Test Location"
    starts_at "2014-02-14 12:00:00"
    ends_at "2014-02-28 12:00:00"
    calendar
  end
end
