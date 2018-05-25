require_relative 'station'

class Journey
  attr_reader :in_journey
  attr_accessor :entry_station, :entry_zone, :exit_station, :exit_zone
  CORRECT_FARE = 1
  PENALTY_FARE = 6

  def initialize (entrystation = nil, entryzone = nil, exitstation = nil, exitzone = nil)
    @entry_station = Station.new(entrystation, entryzone)
    @entry_zone = entryzone
    @in_journey = true

  end

  def finish (exitstation = nil, exitzone)
    @in_journey = false
    @exit_station = Station.new(exitstation, exitzone)
    @exit_zone = exitzone
  end

  def fare
    return PENALTY_FARE if exit_station == nil
    return PENALTY_FARE if entry_station == nil
    return CORRECT_FARE + ((@entry_zone - @exit_zone).abs)
  end

  def complete?
    !@in_journey
  end

end
