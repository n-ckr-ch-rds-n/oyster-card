class Oystercard
  DEFAULT_VALUE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_CHARGE = 1
  attr_reader :balance, :entry_station

  def initialize(balance = DEFAULT_VALUE)
    @balance = balance
  end

  def top_up(amount)
    raise "Balance cannot be above £ #{Oystercard::MAXIMUM_BALANCE}" if full?
    @balance += amount
  end

  def full?
    balance >= MAXIMUM_BALANCE
  end

  def touch_in(station)
    fail "Insufficient funds" if balance < MINIMUM_BALANCE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
  deduct(MINIMUM_CHARGE)
   @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
