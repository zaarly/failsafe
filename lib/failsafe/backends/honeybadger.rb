module Failsafe
  module Backends

    # Failure backend to send errors to Airbrake
    class Honeybadger < Base
      def save
        ::Honeybadger.notify(exception)
      end
    end
  end
end
