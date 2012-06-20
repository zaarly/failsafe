module Failsafe
  module Backends

    # Failure backend to send errors to Airbrake
    class Exceptional < Base
      def save
        ::Exceptional.handle(exception)
      end
    end
  end
end
