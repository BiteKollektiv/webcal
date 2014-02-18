module CalendarsHelper

  def calendar(type = :month, date = Date.today, &block)
    CalendarTable.new(self, type, date, block).table
  end

  class CalendarTable < Struct.new(:view, :type, :date, :callback)
    HEADER = I18n.t('calendar.weekdays').values

    delegate :content_tag, to: :view

    def table
      content_tag :table, class: "calendar" do
        view_type(type)
      end
    end

    def header
      content_tag :tr do
        HEADER.map {|day| content_tag :th, day}.join.html_safe
      end
    end

    def view_type(type)
      case type
      when :month
        header + month
      when :week
        header + week
      else today
      end
    end

    def today
      day_cell(date).html_safe
    end

    def week
      first = date.beginning_of_week
      last = date.end_of_week

      dates = (first..last).to_a
      dates.map { |day| day_cell(day)}.join.html_safe
    end

    def month
      first = date.beginning_of_month.beginning_of_week
      last = date.end_of_month.end_of_week
      weeks = (first..last).to_a.in_groups_of(7)

      weeks.map do |week|
        content_tag :tr do
          week.map{|day| day_cell(day)}.join.html_safe
        end
      end.join.html_safe
    end

    def day_cell(day)
      content_tag :td, view.capture(day, &callback), class: day_classes(day)
    end

    def day_classes(day)
      classes = []
      classes << "today" if day == Date.today
      classes << "other_month" if day.month != date.month
      classes.empty? ? nil : classes.join(" ")
    end
  end
end
