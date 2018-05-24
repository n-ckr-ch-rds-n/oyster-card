require_relative 'journey'

class JourneyLog
  attr_reader :log

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @log = []
  end

  def start(entrystation)
    current_journey(entrystation)
  end

  def finish(exitstation)
    @current_journey.exit_station= exitstation
    @log << @current_journey
  end

  private

  def current_journey(entrystation)
    @current_journey = @journey_class.new(entrystation)
    return @current_journey unless @current_journey.complete?
  end

end
