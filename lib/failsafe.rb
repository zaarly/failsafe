require 'logger'

require 'failsafe/config'
require 'failsafe/failure'

# Mix this module into your classes to get failsafe functionality in
# your classes.
module Failsafe

  # Attach error backends to be fire when errors occur.
  #
  # @example Adding multiple backends
  #   Failsafe::Config.error_backends << Failsafe::Backends::Airbrake
  #   Failsafe::Config.error_backends << Failsafe::Backends::Stderr
  def error_backends
    @backends ||= []
  end

  def failsafe
    begin
      yield
    rescue => e
      Config.error_backends.each do |backend|
        backend.new(e).save
      end
    end
  end
end
