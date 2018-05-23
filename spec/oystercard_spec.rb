require 'oystercard'


describe Oystercard do

subject(:oystercard) { described_class.new }

  context 'balance' do
    it 'checks initial balance' do
      expect(oystercard.balance).to eq(0)
    end
  end

    describe '#top_up' do
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it 'can top up the balance' do
        expect { oystercard.top_up(50) }.to change { oystercard.balance }.by(50)
      end

      it 'raises an error when balance is above £90' do
        oystercard.top_up(Oystercard::MAXIMUM_BALANCE)
        error = "Balance cannot be above £ #{Oystercard::MAXIMUM_BALANCE}"
        expect { oystercard.top_up(1) }.to raise_error error
      end
    end

  context 'journey' do
      it { is_expected.to respond_to(:touch_in) }
      it { is_expected.to respond_to(:touch_out) }

    describe '#touch_in' do
      let(:station) { double :station }

      it 'sets in_journey to true' do
        oystercard.top_up(Oystercard::MINIMUM_BALANCE)
        oystercard.touch_in(station)
        expect(oystercard).to be_in_journey
      end

      it 'raises an error if insufficient funds on the card' do
        expect { oystercard.touch_in(station) }.to raise_error "Insufficient funds"
      end

      # it { is_expected.to respond_to(:touch_in).with(1).argument }
      it 'records the entry station after touch in' do
        oystercard.top_up(Oystercard::MINIMUM_BALANCE)
        oystercard.touch_in(station)
        expect(oystercard.entry_station).to eq station
      end
    end

    describe '#touch_out' do
      let(:station) { double :station }

      it 'sets in_journey to false' do
        #subject.touch_in
        oystercard.touch_out(station)
        expect(oystercard).not_to be_in_journey
      end

      it 'deducts money for trip' do
        amount = Oystercard::MINIMUM_CHARGE
        oystercard.top_up(Oystercard::MINIMUM_BALANCE)
        oystercard.touch_in(station)
        expect { oystercard.touch_out(station) }.to change { oystercard.balance }.by(-amount)
      end
    end

    describe '#in_journey?' do
      it 'is initially not in a journey' do
        expect(oystercard).not_to be_in_journey
      end
    end

    describe '#journey_history' do
      it 'card starts with no history' do
        expect(oystercard.journey_history).to eq ({})
      end


      it 'returns the journey history' do
        oystercard.top_up(Oystercard::MINIMUM_BALANCE)
        oystercard.touch_in("Marylebone")
        oystercard.touch_out("Hammersmith")
        expect(oystercard.journey_history).to eq ({"Marylebone" => "Hammersmith"})
      end
    end
  end
end
