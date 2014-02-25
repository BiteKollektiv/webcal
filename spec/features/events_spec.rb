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

end
