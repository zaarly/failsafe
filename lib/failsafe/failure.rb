module Failsafe
  module Backends
    autoload :Base,     'failsafe/backends/base'

    autoload :Airbrake, 'failsafe/backends/airbrake'
    autoload :Stderr,   'failsafe/backends/stderr'
  end
end
