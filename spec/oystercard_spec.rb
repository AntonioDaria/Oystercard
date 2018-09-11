require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station) { double :station }

  context "card has zero balance" do
    it "checks that it has 0 balance" do
      expect(oystercard.balance).to eq 0
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
      oystercard.top_up(10)
      oystercard.touch_in(station)
      expect(oystercard.in_journey?).to eq true
    end

    it "raises an error if balance is less than MINIMUM_FARE" do
      expect{ oystercard.touch_in("aldgate") }.to raise_error "Insufficient balance"
    end

    it "remembers the entry station" do
      oystercard.top_up(10)
      oystercard.touch_in(station)
      expect(oystercard.entry_station).to eq station
    end

  end

  describe "#touch_out" do
    it "sets in_journey to false" do
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
    end

    it "charges the right fare" do
      expect { oystercard.touch_out }.to change{ oystercard.balance }.by( - Oystercard::MINIMUM_FARE)
    end

    it "resets the entry station" do
      oystercard.top_up(10)
      oystercard.touch_in(station)
      oystercard.touch_out
      expect(oystercard.entry_station).to eq nil
    end
  end

end
