
module Failsafe
  module Backends
    class Stderr < Base
      def self.logger
        @logger ||= ::Logger.new($stderr).tap { |l| l.formatter = Logger::Formatter.new }
      end

      def save
        msg = []
        msg << exception.message
        msg << exception.backtrace.join("\n")
        self.class.logger.error(msg.join)
      end
    end
  end
end
