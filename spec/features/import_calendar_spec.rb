require 'spec_helper'

describe "user can import a calendar" do
  it "should allow the user to upload a calendar" do
    pending "This should work, but the content_type is dropped when uploading .ics files via capybara"

    fixture_file = Rails.root.join('spec', 'fixtures', 'calendars', 'no_events.ics')
    visit root_path
    fill_in "calendar_title", with: "test"
    click_button "Create calendar"
    attach_file("ical", fixture_file)
    click_button "Upload"
    require 'pry'; binding.pry
    expect(page).to have_content("Calendar successfully imported")
  end
end
