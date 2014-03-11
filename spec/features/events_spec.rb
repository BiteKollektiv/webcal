require 'spec_helper'

feature 'event' do
  scenario 'visit events index page' do
    calendar = create(:calendar)

     visit calendar_events_path(locale: I18n.locale, calendar_id: calendar.token_read)
    expect(page).to have_content('List of events')
  end

  scenario 'visit event show page' do
    event= create(:event)
    visit calendar_event_path(locale: I18n.locale, calendar_id: event.calendar.token_read, id: event.id)
    expect(page).to have_content('Back')
  end

  scenario 'should be able to click on edit link' do
    event= create(:event)
    visit calendar_events_path(locale: I18n.locale, calendar_id: event.calendar.token_write)
    expect(page).to have_link('Edit')
  end

  scenario 'visit new page' do
    calendar = create(:calendar)

    visit new_calendar_event_path(locale: I18n.locale, calendar_id: calendar.token_read)
    expect(page).to have_content('New Event')
  end

  scenario 'failure to create' do
    calendar = create(:calendar)

    visit new_calendar_event_path(locale: I18n.locale, calendar_id: calendar.token_read)
    fill_in "event_title",       with: ""
    fill_in "event_description", with: ""
    fill_in "event_starts_at",   with: ""
    fill_in "event_ends_at",     with: ""
    expect { click_button "Create Event" }.not_to change(Event, :count)
  end

  scenario 'successfully create' do
    calendar = create(:calendar)

    visit new_calendar_event_path(locale: I18n.locale, calendar_id: calendar.token_read)
    fill_in "event_title",       with: "Test Title"
    fill_in "event_description", with: "Test Description"
    fill_in "event_starts_at",   with: "2011/01/01"
    fill_in "event_ends_at",     with: "2011/02/02"
    expect { click_button "Create Event" }.to change(Event, :count)
  end

  scenario 'visit edit page' do
    calendar = create(:calendar)
    event = create(:event, calendar: calendar)

    visit edit_calendar_event_path(locale: I18n.locale, calendar_id: calendar.token_read, id: event.id)
    expect(page).to have_content('Edit Event')
  end

  scenario 'failure to update' do
    new_title       = ""
    new_description = ""

    calendar = create(:calendar)
    event = create(:event, calendar: calendar)

    visit edit_calendar_event_path(locale: I18n.locale, calendar_id: calendar.token_read, id: event.id)
    fill_in "event_title",       with: new_title
    fill_in "event_description", with: new_description
    click_button "Update Event"
    expect(event.reload.title).not_to eq new_title
    expect(event.reload.description).not_to eq new_description
  end

  scenario 'successfully update' do
    new_title       = "Test Title"
    new_description = "Test Description"

    calendar = create(:calendar)
    event = create(:event, calendar: calendar)

    visit edit_calendar_event_path(locale: I18n.locale, calendar_id: calendar.token_read, id: event.id)
    fill_in "event_title",       with: new_title
    fill_in "event_description", with: new_description
    click_button "Update Event"
    expect(event.reload.title).to eq new_title
    expect(event.reload.description).to eq new_description
  end

end
