require './journey'

class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @current_journey = nil
    @journeys = []
  end

  def top_up(money)
    raise "Cannot exceed £90!" if @balance + money > LIMIT
    @balance += money
    "Your balance is £#{@balance}."
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance < MINIMUM_FARE
    @current_journey = Journey.new         # Journey object
    @current_journey.start_journey(station)
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @current_journey.end_journey(station)
    @journeys << @current_journey
    @current_journey = nil
  end

  def in_journey?
    @current_journey != nil
  end

  private

  def deduct(fare)
    @balance -= fare
    "Your balance is now £#{@balance}."
  end
end
