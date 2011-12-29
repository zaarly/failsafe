require 'spec_helper'

describe Failsafe::Backends::Base do
  subject { Failsafe::Backends::Base.new(Exception.new) }

  it { should respond_to :save }
end
