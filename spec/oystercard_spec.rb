require 'oystercard'

RSpec.describe Oystercard do
  before(:each) do
    @amount = 5
    @station = double("station")
    allow(subject).to receive(:not_enough_funds?).and_return(false)
  end

  describe '#initialize' do

    it 'has balance of zero' do
      expect(subject.balance).to eq(0)
    end

    it {is_expected.not_to be_in_journey}

  end

  describe '#top_up' do

    it "raise an error if top_up makes balance greater than #{Oystercard::BALANCE_LIMIT}" do
      message = "Top up declined. Balance would exceed £#{Oystercard::BALANCE_LIMIT}"
      expect { subject.top_up(91) }.to raise_error(message)
    end

    it 'takes an argument and increment the balance' do
      expect { subject.top_up(@amount) }.to change { subject.balance }.by(@amount)
    end
  end

  describe '#touch_in' do
    it "prevents touching in if current balance is less than #{Oystercard::MINIMUM_FARE}" do
      card = Oystercard.new
      message = "Minimum balance of £#{Oystercard::MINIMUM_FARE} required"
      expect { card.touch_in(@station) }.to raise_error(message)
    end
    it "updates entry_station" do
      subject.touch_in(@station)
      expect(subject.entry_station).to eq(@station)
    end
  end

  describe '#touch_out' do
    it 'set in_journey to false' do
      subject.touch_in(@station)
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'deducts minimum fare' do
      expect{subject.touch_out}.to change{subject.balance}.by(-Oystercard::MINIMUM_FARE)
    end

    it 'clears entry_station' do
      subject.touch_in(@station)
      subject.touch_out
      expect(subject.entry_station).to be_nil
    end
  end
end
