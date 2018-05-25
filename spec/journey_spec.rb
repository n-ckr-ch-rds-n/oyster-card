require 'journey'

describe Journey do
  context 'There is an entry station and an exit station' do

    subject(:journey) { described_class.new("Hammersmith", 1, "Angel", 3) }
    let(:station) { double :Station }

      it 'responds to #finish, #fare, and #complete' do
        expect(journey).to respond_to(:finish)
        expect(journey).to respond_to(:fare)
        expect(journey).to respond_to(:complete?)
      end

      it 'has an entry station' do
        expect(journey.entry_station).to eq (station)
      end

      it 'has en exit station' do
        expect(journey.exit_station).to eq "Angel"
      end

      it 'starts a journey at initialization' do
        expect(journey.in_journey).to eq true
      end

      describe '#complete?' do
        it 'returns true when in_journey is false' do
          journey.finish
          expect(journey.complete?).to eq true
        end
      end
  end

  context 'There is no entry station or exit station' do

    subject(:journey) { described_class.new }

      describe '#fare' do
        it 'returns the penalty fare when there is no entry or exit station' do
          expect(journey.fare).to eq Journey::PENALTY_FARE
        end
      end

  end
end
