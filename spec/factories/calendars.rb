FactoryGirl.define do
  factory :calendar do
    title "MyString"
    description "MyString"

    factory :calendar_with_events do
      after(:create) do |calendar|
        FactoryGirl.create_list(:event, 2, calendar: calendar)
      end
    end
  end
end
