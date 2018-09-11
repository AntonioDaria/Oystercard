class Journey

  attr_reader :station_in, :station_out, :fare_paid

  def initialize
    @station_in = nil
    @station_out = nil
    @fare_paid = nil
  end

  def fare
    @fare_paid = journey_complete? ? 1 : 6
  end

  def start_journey(station)
    @station_in = station
  end

  def end_journey(station)
    @station_out = station
  end

  def journey_complete?
    @station_in && @station_out
  end

end
