require 'spec_helper'

describe Failsafe::Backends::Exceptional do
  let(:exception) { stub("exception") }

  subject { Failsafe::Backends::Exceptional.new(exception) }

  it "tells airbrake to notify or ignore the exception" do
    ::Exceptional.expects(:handle).with(exception)
    subject.save
  end
end

