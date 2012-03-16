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

  @@disabled = false

  # Determines if failsafe should rescue errors or let them bubble up.
  #
  # @default false
  # @return [Boolean]
  def self.disabled; @@disabled; end
  def self.disabled?; disabled; end

  def self.disabled=(val)
    @@disabled = val
  end

  # Wraps code in a begin..rescue and delivers exceptions
  # to the configured error backends.
  #
  # @todo make this threadsafe
  def self.failsafe
    # Let errors bubble up if failsafe has been disabled
    if disabled?
      return yield
    end

    begin
      yield
    rescue => e
      error_backends.each do |backend|
        backend.new(e).save
      end
    end
  end
end
