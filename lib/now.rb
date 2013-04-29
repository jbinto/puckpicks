class Now
  MOCK = true

  def self.now
    # Time.zone.now => Thu, 18 Apr 2013 23:07:53 EDT -04:00
    # Time.zone.now.class => ActiveSupport::TimeWithZone

    if MOCK
      Time.zone.parse('2013-04-30 18:00:00')
    else
      Time.zone.now
    end
  end

  def self.today
    # Time.zone.today => Thu, 18 Apr 2013 (Date)
    # Time.zone.now.class => ActiveSupport::TimeWithZone

    if MOCK
      Date.parse('2013-04-30')
    else
      Time.zone.today
    end

  end

end
