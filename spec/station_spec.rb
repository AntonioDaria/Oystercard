require 'station'

describe Station do

  subject { described_class.new("name", "zone") }

  it "should have a name" do
    expect(subject.name).to eq "name"
  end

  it "should have a zone" do
    expect(subject.zone).to eq "zone"
  end
end
