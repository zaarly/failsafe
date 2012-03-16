module Failsafe
  module Backends

    # Failure backend to send errors to Airbrake
    class Airbrake < Base
      def save
        ::Airbrake.notify_or_ignore(exception)
      end
    end
  end
end
