require 'oystercard'

RSpec.describe Oystercard do
  before(:each) do
    @amount = 5
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
    it 'set in_journey to true' do
      subject.top_up(@amount)
      subject.touch_in
      expect(subject).to be_in_journey
    end
    it "prevents touching in if current balance is less than #{Oystercard::MINIMUM_FARE}" do
      message = "Minimum balance of £#{Oystercard::MINIMUM_FARE} required"
      expect { subject.touch_in }.to raise_error(message)
    end
  end

  describe '#touch_out' do
    it 'set in_journey to false' do
      subject.top_up(@amount)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

    it 'deducts minimum fare' do
      expect{subject.touch_out}.to change{subject.balance}.by (-Oystercard::MINIMUM_FARE)
    end

  end
end
