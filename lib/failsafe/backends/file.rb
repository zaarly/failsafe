module Failsafe
  module Backends

    # File failure backend. Writes exception backtraces to a logfile.
    class File < Base
      def self.log_file_path=(log_file_path)
        @logger = nil
        @log_file_path = log_file_path
      end

      def self.log_file_path
        @log_file_path || ::File.join(Rails.root, 'log', 'failsafe_errors.log')
      end

      def self.configure
        yield(self)
      end

      def self.logger
        @logger ||= ::Logger.new(log_file_path).tap { |l| l.formatter = Logger::Formatter.new }
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
