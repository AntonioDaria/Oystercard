require 'oystercard'


# I want money on my card

describe Oystercard do
subject(:oystercard) { described_class.new }

  it "checks balance" do
    expect(oystercard).to respond_to(:balance)
  end
  it "checks that it has 0 balance" do
    expect(oystercard.balance).to eq 0
  end

end
