class Now
  def self.now
    # Time.zone.now => Thu, 18 Apr 2013 23:07:53 EDT -04:00
    # Time.zone.now.class => ActiveSupport::TimeWithZone

    Time.zone.parse('2013-04-18 15:00:00')
  end

  def self.today
    # Time.zone.today => Thu, 18 Apr 2013 (Date)
    # Time.zone.now.class => ActiveSupport::TimeWithZone

    Date.parse('2013-04-18')
  end

end
