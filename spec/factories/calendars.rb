FactoryGirl.define do
  factory :calendar do
    title "MyString"
    description "A longer calendar description"

    factory :calendar_with_events do
      after(:create) do |calendar|
        FactoryGirl.create_list(:event, 2, calendar: calendar)
      end
    end

    factory :calendar_with_events_with_tags do
      after(:create) do |calendar|
        tag_names = ["test", "tag"]
        FactoryGirl.create_list(:event, 2, calendar: calendar, tag_names: tag_names)
      end
    end
  end
end
