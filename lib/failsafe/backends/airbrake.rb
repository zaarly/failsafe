module Failsafe
  module Backends

    # Send errors to Airbrake
    class Airbrake < Base
      def save
        ::Airbrake.notify_or_ignore(exception)
      end
    end
  end
end
