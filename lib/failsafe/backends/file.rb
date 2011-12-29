module Failsafe
  module Backends
    class File < Base
      def self.logger
        @logger ||= ::Logger.new(::File.join(Rails.root, 'log', 'event_errors.log')).tap { |l| l.formatter = Logger::Formatter.new }
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
