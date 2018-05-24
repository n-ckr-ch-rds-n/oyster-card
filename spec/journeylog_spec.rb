require 'journeylog'
require 'journey'

describe JourneyLog do
  let(:journey_class) { Journey }
  let(:journey) { double :journey }
  let(:exit_station) { double :exit_station }
  let(:entry_station) { double :entry_station }
  subject(:journeylog) { described_class.new(journey_class) }

  it 'responds to #start' do
    expect(journeylog).to respond_to(:start).with(1).argument
  end

  describe '#start' do
    it 'starts a new journey with an entry station' do
      allow(journey_class).to receive(:new).with(:entry_station).and_return(journey)
      allow(journey).to receive(:complete?).and_return false
      expect(journeylog.start(:entry_station)).to eq journey
    end
  end

  it 'responds to #finish' do
    expect(journeylog).to respond_to(:finish).with(1).argument
  end

  describe '#finish' do
    it 'gives an exit station to a journey' do
      allow(journey).to receive(:exit_station=).and_return(exit_station)
      allow(journey_class).to receive(:new).with(:entry_station).and_return(journey)
      allow(journey).to receive(:complete?).and_return true
      subject.start(:entry_station)
      subject.finish(:exit_station)
      expect(subject.log).to include journey
    end
  end


end
