class Oystercard
  attr_reader :balance, :BALANCE_LIMIT
  BALANCE_LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(number)
    raise "Top up declined. Balance would exceed £#{BALANCE_LIMIT}" if exceed_limit?(number)

    @balance += number
  end

  def deduct(number)
    @balance -= number
  end

  def in_journey?
    @in_journey
  end

  private

  def exceed_limit?(number)
    @balance + number > BALANCE_LIMIT
  end

end
