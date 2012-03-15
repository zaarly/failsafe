$:.push(File.expand_path(File.dirname(__FILE__)))
$:.push(File.expand_path(File.dirname(__FILE__)) + '/../lib')

require 'failsafe'

RSpec.configure do |config|
  config.mock_with :mocha
  config.after { Failsafe.error_backends.clear }
end