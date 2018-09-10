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

  describe "top_up" do
    it "responds to top_up" do
      expect(oystercard).to respond_to(:top_up).with(1).argument
    end

    it "adds money to the oystercard" do
      expect{ oystercard.top_up 10 }.to change{ oystercard.balance }.by 10
    end

    it "raises an error if balance exceeds £90" do
      limit = Oystercard::LIMIT
      oystercard.top_up(limit)
      expect { oystercard.top_up 1 }.to raise_error "Cannot exceed £90!"
    end

    describe '#pay_fare' do
      it 'responds to pay_fare' do
        expect(oystercard).to respond_to(:pay_fare).with(1).argument
      end

      it "deducts money" do
        oystercard.top_up(10)
        expect { oystercard.pay_fare 5 }.to change{ oystercard.balance}.by -5 
      end
    end
  end

end
