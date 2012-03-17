require 'spec_helper'

begin
  Airbrake
rescue NameError
  module Airbrake; end
end

describe Failsafe::Backends::Airbrake do
  let(:exception) { stub("exception") }

  subject { Failsafe::Backends::Airbrake.new(exception) }

  it "tells airbrake to notify or ignore the exception" do
    Airbrake.expects(:notify_or_ignore).with(exception)
    subject.save
  end
end

