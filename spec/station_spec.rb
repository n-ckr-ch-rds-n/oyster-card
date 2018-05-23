require 'station'

describe Station do
  it 'has a name variable' do
      station = Station.new("Hammersmith", 1)
      expect(station.name).to eq "Hammersmith"
  end

  it 'has a zone variable' do
      station = Station.new("Hammersmith", 1)
      expect(station.zone).to eq 1
  end

end
