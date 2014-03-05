require 'icalendar'


ICAL_FORMATTER = lambda do |calendar|
  ical_calendar = Icalendar::Calendar.new
  ical_calendar.prodid = "webcal-alpha"

  calendar.events.each do |event|
    ical_event = Icalendar::Event.new
    ical_event.start = event.starts_at
    ical_event.end = event.ends_at

    ical_calendar.add_event(ical_event)
  end
  ical_calendar.publish

  ical_calendar
end

class CalendarExporter
  def initialize(calendar, &formatter)
    @calendar = calendar
    @formatter = formatter
  end

  def export
    @formatter.call(@calendar)
    # TODO: save the file and return the path
  end
end

# Usage:
# CalendarExporter.new(calendar, ICAL_EXPORTER)
# CalendarExporter.new(calendar, RSS_EXPORTER)
# This is called the Strategy Pattern
