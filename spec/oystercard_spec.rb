require 'oystercard'

describe Oystercard do

  context 'balance' do
    it 'checks initial balance' do
      expect(subject.balance).to eq(0)
    end
  end

    describe '#top_up' do
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it 'can top up the balance' do
        expect { subject.top_up(50) }.to change { subject.balance }.by(50)
      end

      it 'raises an error when balance is above £90' do
        subject.top_up(Oystercard::MAXIMUM_BALANCE)
        error = "Balance cannot be above £ #{Oystercard::MAXIMUM_BALANCE}"
        expect { subject.top_up(1) }.to raise_error error
      end
    end

  context 'journey' do
      it { is_expected.to respond_to(:touch_in) }
      # it { is_expected.to respond_to(:touch_out) }

    describe '#touch_in' do
      it 'sets in_journey to true' do
        subject.top_up(Oystercard::MINIMUM_BALANCE)
        subject.touch_in
        expect(subject).to be_in_journey
      end

      it 'raises an error if insufficient funds on the card' do
        expect { subject.touch_in }.to raise_error "Insufficient funds"
      end
    end

    describe '#touch_out' do
      it 'sets in_journey to false' do
        #subject.touch_in
        subject.touch_out
        expect(subject).not_to be_in_journey
      end

      it 'deducts money for trip' do
        amount = Oystercard::MINIMUM_CHARGE
        subject.top_up(Oystercard::MINIMUM_BALANCE)
        subject.touch_in
        expect { subject.touch_out }.to change { subject.balance }.by(-amount)
      end
    end

    describe '#in_journey?' do
      it 'is initially not in a journey' do
        expect(subject).not_to be_in_journey
      end
    end
  end
end
