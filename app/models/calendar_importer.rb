require 'icalendar'

# As a convention, Ical stuff is prepended with ical_ and
# ActiveRecord related stuff is the same.
class CalendarImporter
  def initialize(calendar, file)
    @calendar = calendar
    @file = file
  end

  def import
    ical_calendars = Icalendar.parse(File.open(@file))

    ical_calendars.each do |ical_calendar|
      tagname = ical_calendar.x_wr_calname.first

      ical_calendar.events.each do |ical_event|
        add_event_to_calendar(ical_event, tagname)
      end
    end
  end

  protected

  def add_event_to_calendar(ical_event, tagname)
    opts = {
      title: ical_event.summary,
      description: ical_event.description,
      location: ical_event.location,
      starts_at: ical_event.dtstart,
      ends_at: ical_event.dtend,
      calendar: @calendar
    }
    event = Event.new(opts)
    event.tag_names << tagname

    @calendar.events.create!(event.attributes)
  end
end
