module Failsafe
  module Backends
    class Base
      attr_accessor :exception

      def initialize(exception)
        @exception = exception
      end

      # Implement in subclasses
      def save
      end
    end
  end
end
