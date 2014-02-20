require 'spec_helper'

describe "navigating a calendar" do
  before :all do
    @calendar = create(:calendar)
  end

  describe "clicking on a view type" do
    it "should show the monthly view first" do
      visit calendar_path(locale: I18n.locale, id: @calendar.token_read)
      expect(page).to have_selector("table td", minimum: 28)
    end

    it "should show the proper weekly view" do
      visit calendar_path(locale: I18n.locale, id: @calendar.token_read)
      click_link "Week"
      expect(page).to have_selector("table td", count: 7)
    end

    it "should show the proper daily view" do
      visit calendar_path(locale: I18n.locale, id: @calendar.token_read)
      click_link "Day"
      expect(page).to have_selector("table td", count: 1)
    end
  end
end
