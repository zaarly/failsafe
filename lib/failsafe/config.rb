module Failsafe
  module Config
    def error_backends
      @backends ||= []
    end
  end
end
