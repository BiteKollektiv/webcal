require 'icalendar'
require 'fileutils'

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
  DOWNLOAD_DIR = Rails.root.join('public', 'downloads')

  def initialize(calendar, &formatter)
    @calendar = calendar
    @formatter = formatter
  end

  def export
    ical = @formatter.call(@calendar)

    FileUtils.mkdir_p(DOWNLOAD_DIR)
    filename = Rails.root.join(DOWNLOAD_DIR, SecureRandom.urlsafe_base64 + ".ics")

    File.open(filename, 'wb') do |file|
      file.write(ical)
    end

    filename.to_s
  end
end

# Usage:
# CalendarExporter.new(calendar, ICAL_EXPORTER)
# CalendarExporter.new(calendar, RSS_EXPORTER)
# This is called the Strategy Pattern
