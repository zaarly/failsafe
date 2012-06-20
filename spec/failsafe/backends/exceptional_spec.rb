require 'spec_helper'

begin
  Exceptional
rescue NameError
  module Exceptional;end
end

describe Failsafe::Backends::Exceptional do
  let(:exception) { stub("exception") }

  subject { Failsafe::Backends::Exceptional.new(exception) }

  it "tells airbrake to notify or ignore the exception" do
    ::Exceptional.expects(:handle).with(exception)
    subject.save
  end
end

