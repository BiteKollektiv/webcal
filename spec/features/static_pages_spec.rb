require 'spec_helper'

feature 'calendar' do
  scenario 'Create calendar in homepage' do
    pending "fix this"
    visit root_path
    page.has_xpath?('//*[@id="new_calendar"]/input[2]')
    click_button('Create calendar')
    expect(page).to have_content('Calendar successfully created')
  end
end
