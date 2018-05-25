require_relative 'station'
require_relative 'journey'
require_relative 'journeylog'

class Oystercard
  DEFAULT_VALUE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :exit_station

  def initialize(balance = DEFAULT_VALUE)
    @balance = balance
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    raise "Balance cannot be above £ #{MAXIMUM_BALANCE}" if ((@balance + amount) > MAXIMUM_BALANCE)
    raise "Balance cannot be above £ #{MAXIMUM_BALANCE}" if full?
    @balance += amount
  end

  def full?
    @balance >= MAXIMUM_BALANCE
  end

  def touch_in(entrystation = nil, entryzone)
    fail "Insufficient funds" if balance < MINIMUM_BALANCE
    @journey_log.start(entrystation, entryzone)
  end

  def touch_out(exitstation = nil, exitzone)
    @journey_log.finish(exitstation, exitzone)
    deduct(@journey_log.fare)
  end

  def journey_log
    @journey_log.journeys
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
