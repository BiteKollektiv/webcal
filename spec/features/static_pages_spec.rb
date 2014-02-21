require 'spec_helper'

describe 'calendar user' do
  it 'should create a new calendar from the homepage' do
    visit root_path
    click_button('Create calendar')
    expect(page).to have_content('Calendar was successfully created')
  end
end
