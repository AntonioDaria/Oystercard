
class Oystercard
  LIMIT = 90
  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(money)
    @balance += money
    raise "Cannot exceed £90!" if @balance > LIMIT
    "Your balance is #{@balance}."
  end
end
