class Oystercard
  attr_reader :balance, :BALANCE_LIMIT
  BALANCE_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(number)
    raise "Top up declined. Balance would exceed £#{BALANCE_LIMIT}" if exceed_limit?(number)

    @balance += number
  end

  def deduct(number)
    @balance -= number
  end

  private

  def exceed_limit?(number)
    @balance + number > BALANCE_LIMIT
  end

end
