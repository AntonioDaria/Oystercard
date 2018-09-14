require 'oystercard'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  subject(:journey_oyster) { described_class.new(mock_journey) }
  let(:station_in) { double :station }
  let(:station_out) { double :station }
  let(:mock_journey) { double :mock_journey }
  let(:mock_journey_instance) { double :mock_journey_instance }

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

     it "deducts the penalty fare if still in journey" do
       oystercard.top_up(10)
       oystercard.touch_in(station_in)
       expect{ oystercard.touch_in(station_in) }.to change{oystercard.balance}.by(-6)
     end
  end

  describe "#touch_out" do
    it "sets in_journey to false" do
      oystercard.top_up(10)
      oystercard.touch_in(station_in)
      oystercard.touch_out(station_out)
      expect(oystercard.in_journey?).to eq false
    end

    it "charges the right fare" do
      oystercard.top_up(10)
      oystercard.touch_in(station_in)
      expect { oystercard.touch_out(station_out) }.to change{ oystercard.balance }.by( - Oystercard::MINIMUM_FARE)
    end

    it "resets the current journey" do
      oystercard.top_up(10)
      oystercard.touch_in(station_in)
      oystercard.touch_out(station_out)
      expect(oystercard.current_journey).to eq nil
    end

    it "should store journeys" do
      allow(mock_journey).to receive(:new).and_return(mock_journey_instance)
      allow(mock_journey_instance).to receive(:start_journey)
      allow(mock_journey_instance).to receive(:end_journey)
      allow(mock_journey_instance).to receive(:fare).and_return(1)

      journey_oyster.top_up(10)
      journey_oyster.touch_in(station_in)
      journey_oyster.touch_out(station_out)
      expect(journey_oyster.journeys).to eq [mock_journey_instance]
    end
  end

end
