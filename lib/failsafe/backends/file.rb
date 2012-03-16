module Failsafe
  module Backends

    # File failure backend. Writes exception backtraces to a logfile.
    class File < Base
      def self.logger
        @logger ||= ::Logger.new(::File.join(Rails.root, 'log', 'failsafe_errors.log')).tap { |l| l.formatter = Logger::Formatter.new }
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
