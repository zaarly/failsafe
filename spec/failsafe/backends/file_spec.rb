require 'spec_helper'
require 'tempfile'

begin
  Rails
rescue NameError
  module Rails; end
end

describe Failsafe::Backends::File, "configuration" do
  let(:log_file_path) { Tempfile.new("failsafe").path }
  let(:tmpdir)        { Dir.mktmpdir("failsafe") }

  it "allows for setting the log file path" do
    Failsafe::Backends::File.configure do |c|
      c.log_file_path = log_file_path
    end

    Failsafe::Backends::File.log_file_path.should == log_file_path
  end

  it "defaults the log file to the [Rails.root]/log/failsafe_errors.log" do
    Failsafe::Backends::File.configure do |c|
      c.log_file_path = nil
    end

    Rails.stubs(:root).returns(tmpdir)
    Failsafe::Backends::File.log_file_path.should == ::File.join(tmpdir, "log", "failsafe_errors.log")
  end
end

describe Failsafe::Backends::File do
  let(:exception) { RuntimeError.new("Oh noez!") }
  let(:log_file)  { Tempfile.new("failsafe") }

  subject { Failsafe::Backends::File.new(exception) }

  before do
    Failsafe::Backends::File.log_file_path = log_file.path
    exception.set_backtrace(["#{__FILE__}:6"])
    subject.save
  end

  after do
    log_file.close!
  end

  it "logs to the logfile when a exception is raised" do
    log_file.read.should =~ /Oh noez!/
  end

  it "logs the backtrace to the file" do
    log_file.read.should =~ /file_spec.rb:6/
  end
end

