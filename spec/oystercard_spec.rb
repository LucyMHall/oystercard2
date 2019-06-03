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

  describe '#top_up' do

    it 'takes an argument and increment the balance' do
      expect(subject.top_up(3)).to eq(3)
    end
  end

end
