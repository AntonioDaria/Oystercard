require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }

  context "card has zero balance" do
    it "checks that it has 0 balance" do
      expect(oystercard.balance).to eq 0
    end
  end

  context "card has positive balance" do
    describe '#pay_fare' do
      it "deducts money" do
        oystercard.top_up(10)
        expect { oystercard.pay_fare 5 }.to change{ oystercard.balance}.by -5
      end
    end
  end

  describe "top_up" do
    it "adds money to the oystercard" do
      expect{ oystercard.top_up 10 }.to change{ oystercard.balance }.by 10
    end

    it "raises an error if balance exceeds £90" do
      limit = Oystercard::LIMIT
      oystercard.top_up(limit)
      expect { oystercard.top_up 1 }.to raise_error "Cannot exceed £90!"
    end
  end

  describe "#touch_in" do
    it "sets in_journey to true" do
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq true
    end
  end

  describe "#touch_out" do
    it "sets in_journey to false" do
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end
  end

end
