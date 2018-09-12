require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:station_in) { double :station }
  let(:station_out) { double :station }
  context "card has zero balance" do
    it "checks that it has 0 balance" do
      expect(oystercard.balance).to eq 0
    end
  end

  describe "#top_up" do
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
      oystercard.touch_in(station_in)
      expect(oystercard.in_journey?).to eq true
    end

    it "raises an error if balance is less than MINIMUM_FARE" do
      expect{ oystercard.touch_in(station_in) }.to raise_error "Insufficient balance"
    end

    it "remembers the entry station" do
      oystercard.top_up(10)
      oystercard.touch_in(station_in)
      expect(oystercard.current_journey.station_in).to eq station_in
    end

  end

  describe "#touch_out" do
    it "sets in_journey to false" do
      oystercard.touch_out(station_out)
      expect(oystercard.in_journey?).to eq false
    end

    it "charges the right fare" do
      expect { oystercard.touch_out(station_out) }.to change{ oystercard.balance }.by( - Oystercard::MINIMUM_FARE)
    end

    it "resets the current journey" do
      oystercard.top_up(10)
      oystercard.touch_in(station_in)
      oystercard.touch_out(station_out)
      expect(oystercard.current_journey).to eq nil
    end

    it "should store journeys" do
      oystercard.top_up(10)
      oystercard.touch_in(station_in)
      oystercard.touch_out(station_out)
      expect(oystercard.journeys).to eq []
    end
  end

end
