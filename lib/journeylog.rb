require_relative 'journey'

class JourneyLog
  :log

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @log = []
  end

  def start(entrystation, entryzone)
    current_journey(entrystation, entryzone)
  end

  def finish(exitstation, exitzone)
    @current_journey.exit_station= exitstation
    @current_journey.exit_zone= exitzone
    @current_journey.finish(exitstation, exitzone)
    @log << @current_journey
  end

  def journeys
    @log.dup
  end

  def fare
    @current_journey.fare
  end

  private

  def current_journey(entrystation, entryzone)
    @current_journey = @journey_class.new(entrystation, entryzone)
    return @current_journey unless @current_journey.complete?
  end

end
