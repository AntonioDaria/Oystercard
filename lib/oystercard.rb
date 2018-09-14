require_relative 'journey'

class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :current_journey, :journeys

  def initialize(journey_type = Journey)
    @balance = 0
    @current_journey = nil
    @journeys = []
    @journey_type = journey_type
  end

  def top_up(money)
    raise "Cannot exceed £90!" if @balance + money > LIMIT
    @balance += money
    "Your balance is £#{@balance}."
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance < MINIMUM_FARE
    if in_journey?
      deduct
      @journeys << @current_journey
      @current_journey = nil
    end
    @current_journey = @journey_type.new         # Journey object
    @current_journey.start_journey(station)

  end

  def touch_out(station)
    @current_journey.end_journey(station) if in_journey?
    deduct
    @journeys << @current_journey if in_journey?
    @current_journey = nil
  end

  def in_journey?
    @current_journey != nil
  end

  private

  def deduct
    @balance -= @current_journey.fare
    "Your balance is now £#{@balance}."
  end
end
