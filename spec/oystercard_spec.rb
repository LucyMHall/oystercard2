require 'oystercard'

RSpec.describe Oystercard do

  it 'responds to #balance' do
    expect(subject.balance).to be_instance_of(Integer)
  end

  it 'has zero when intialized' do
    oystercard = Oystercard.new
    expect(oystercard.balance).to eq(0)
  end

end
