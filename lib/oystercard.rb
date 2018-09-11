class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(money)
    raise "Cannot exceed £90!" if @balance + money > LIMIT
    @balance += money
    "Your balance is £#{@balance}."
  end

  def touch_in(station)
    raise "Insufficient balance" if @balance < MINIMUM_FARE
    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def deduct(fare)
    @balance -= fare
    "Your balance is now £#{@balance}."
  end
end
