class LotteryGenerator

  attr_accessor :seed

  def initialize
    @seed = 217894217468732695
    @prng = Random.new(@seed)
  end

  def generate_number
    (@prng.rand * 100000000).to_i
  end

  private 
  def reset_generator
    @prng = Random.new(@seed)
  end
end
