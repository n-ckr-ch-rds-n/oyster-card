require_relative 'station'

class Journey
  attr_reader :entry_station, :in_journey
  attr_accessor :exit_station
  CORRECT_FARE = 1
  PENALTY_FARE = 6

  def initialize (entry_station = nil, exit_station = nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @in_journey = true
  end

  def finish
    @in_journey = false
  end

  def fare
    return PENALTY_FARE if exit_station == nil
    return PENALTY_FARE if entry_station == nil
    return CORRECT_FARE
  end

  def complete?
    !@in_journey
  end

end
