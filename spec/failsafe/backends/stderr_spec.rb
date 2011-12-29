require 'spec_helper'

describe Failsafe::Backends::Stderr do
  let!(:stderr_bucket) { $stderr }
  let(:exception)      { RuntimeError.new("Oh noez!") }

  subject { Failsafe::Backends::Stderr.new(exception) }

  before do
    $stderr = StringIO.new
    Failsafe::Backends::Stderr.stub!(:logger => ::Logger.new($stderr))
    exception.set_backtrace(["#{__FILE__}:6"])
    subject.save
    $stderr.rewind
  end

  after  { $stderr = stderr_bucket }

  it "logs something to stderr when a exception is raised" do
    $stderr.read.should =~ /Oh noez!/
  end

  it "logs the backtrace" do
    $stderr.read.should include "stderr_spec.rb:6"
  end
end

