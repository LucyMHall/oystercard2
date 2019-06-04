require 'oystercard'

RSpec.describe Oystercard do

  describe '#balance' do

    it 'responds to #balance' do
      expect(subject.balance).to be_instance_of(Integer)
    end

    it 'has zero when intialized' do
      expect(subject.balance).to eq(0)
    end

  end

  describe 'if #top up #exceed_limit?' do
    it 'returns true if balance exceeded' do
      expect(subject.exceed_limit?(91)).to eq true
    end

  end

  describe '#top_up' do

    it 'raise an error if top_up makes balance greater than LIMIT' do
      limit = Oystercard::BALANCE_LIMIT
      expect { subject.top_up(91) }.to raise_error "Top up declined. Limit balance would be exceed £#{limit}"
    end

    it 'takes an argument and increment the balance' do
      expect(subject.top_up(3)).to eq(3)
    end
  end

  describe '#deduct' do

    it 'takes an argument and deducts it from the balance' do
      oystercard = Oystercard.new
      oystercard.top_up(20)
      expect(oystercard.deduct(5)).to eq(15)
    end
  end



end
