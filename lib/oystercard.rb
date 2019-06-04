class Oystercard
  attr_reader :balance, :entry_station
  BALANCE_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
  end

  def top_up(number)
    raise "Top up declined. Balance would exceed £#{BALANCE_LIMIT}" if exceed_limit?(number)

    @balance += number
  end

  def touch_in(station)
    raise "Minimum balance of £#{MINIMUM_FARE} required" if not_enough_funds?

    @entry_station = station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station.nil? ? false : true
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
