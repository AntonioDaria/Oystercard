class Journey

  def initialize
    @station_in = nil
    @station_out = nil
  end

  def fare
  end

  def start_journey(station)
    @station_in = station
  end

  def end_journey(station)
    @station_out = station
  end

  def journey_complete?
  end

end
