class Oystercard
  attr_reader :balance
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(number)
    raise "Top up declined. Balance would exceed £#{BALANCE_LIMIT}" if exceed_limit?(number)

    @balance += number
  end

  def touch_in
    raise "Minimum balance of £#{MINIMUM_FARE} required" if not_enough_funds?

    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @in_journey
  end

  def not_enough_funds?
    balance < MINIMUM_FARE
  end

  private

  def exceed_limit?(number)
    balance + number > BALANCE_LIMIT
  end

  def deduct(number)
    @balance -= number
  end

end
