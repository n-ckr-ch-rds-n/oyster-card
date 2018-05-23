require 'pry'
require_relative 'station'
require_relative 'journey'

class Oystercard
  DEFAULT_VALUE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :exit_station, :journey_history

  def initialize(balance = DEFAULT_VALUE)
    @balance = balance
    @journey_history = {}
  end

  def top_up(amount)
    raise "Balance cannot be above £ #{Oystercard::MAXIMUM_BALANCE}" if full?
    @balance += amount
  end

  def full?
    balance >= MAXIMUM_BALANCE
  end

  def touch_in(station = nil)
    fail "Insufficient funds" if balance < MINIMUM_BALANCE
    start_journey
  end

  def touch_out(station = nil)
    @journey.exit_station = station
    deduct(@journey.fare)
    @journey.finish
    log_journey
  end

private

  def deduct(amount)
    @balance -= amount
  end

  def log_journey
    journey_history[@journey.entry_station] = @journey.exit_station
  end

  def start_journey
    @journey = Journey.new(station)
  end

end
