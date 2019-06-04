require 'oystercard'

RSpec.describe Oystercard do
  before(:each) do
    @amount = 5
  end

  describe '#initialize' do

    it 'has balance of zero' do
      expect(subject.balance).to eq(0)
    end

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

  describe '#deduct' do

    it 'takes an argument and deducts it from the balance' do
      subject.top_up(@amount)
      expect { subject.deduct(@amount) }.to change { subject.balance }.by(-@amount)
    end
  end

end
