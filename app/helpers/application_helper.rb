module ApplicationHelper
    def today_text
      date_only(Time.zone.today)
    end

    def date_only(date)
      date.strftime('%A, %b %d')
    end

    def time_only(date)
      date.localtime.strftime('%l:%M %p')
    end
end
