require 'journey'

describe Journey do

  subject { described_class.new }

  it "starts a journey" do
    subject.start_journey("aldgate")
    expect(subject.station_in).to eq "aldgate"
  end

  it "ends a journey" do
    subject.end_journey("aldgate")
    expect(subject.station_out).to eq "aldgate"
  end

  it "calculates the fare" do
    subject.start_journey("aldgate")
    subject.end_journey("waterloo")
    subject.fare
    expect(subject.fare_paid).to eq 1
  end
end
