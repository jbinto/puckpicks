module ApplicationHelper
    def date_only(date)
      date.strftime('%A, %b %d').strip
    end

    def time_only(date)
      date.localtime.strftime('%l:%M %p').strip
    end

    def date_and_time(date)
      date.localtime.strftime('%A, %b %d %l:%M %p').strip
    end
end
