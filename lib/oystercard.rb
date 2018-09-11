class Oystercard
  LIMIT = 90
  MINIMUM_FARE = 1
  attr_reader :balance

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(money)
    raise "Cannot exceed £90!" if @balance + money > LIMIT
    @balance += money
    "Your balance is £#{@balance}."
  end

  def pay_fare(fare)
    @balance -= fare
    "Your balance is now £#{@balance}."
  end

  def touch_in
    raise "Insufficient balance" if @balance < MINIMUM_FARE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end
end
