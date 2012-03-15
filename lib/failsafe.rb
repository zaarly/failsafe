require 'logger'

require 'failsafe/failure'

module Failsafe

  # Attach error backends to be fire when errors occur.
  #
  # @example Adding multiple backends
  #   Failsafe::Config.error_backends << Failsafe::Backends::Airbrake
  #   Failsafe::Config.error_backends << Failsafe::Backends::Stderr
  def self.error_backends
    @backends ||= []
  end

  # Wraps code in a begin..rescue and delivers exceptions
  # to the configured error backends.
  #
  # @todo make this threadsafe
  def self.failsafe
    begin
      yield
    rescue => e
      error_backends.each do |backend|
        backend.new(e).save
      end
    end
  end
end
