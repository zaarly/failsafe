require 'spec_helper'

describe "configuring error backends" do
  it "adds the error backend class to the config" do
    some_backend_class = Struct.new(:save)
    Failsafe.error_backends << some_backend_class
    Failsafe.error_backends.should include some_backend_class
  end
end

describe Failsafe, ".failsafe" do
  class DangerousClass
    def boom_boom
      raise RuntimeError.new "room!"
    end
  end

  before { Failsafe.error_backends << MockFailureBackend }
  let(:danger) { DangerousClass.new }

  subject { Failsafe.failsafe { danger.boom_boom } }

  it "does not raise an error when wrapped with failsafe" do
    expect {
      subject
    }.not_to raise_error
  end

  it "notifies backends of the exception" do
    MockFailureBackend.any_instance.expects(:save)
    subject
  end
end

describe "disabling failsafe" do
  it "is not disabled by default" do
    Failsafe.should_not be_disabled
  end

  context "when false" do
    before { Failsafe.disabled = false }

    it "allows exception to bubble up" do
      expect {
        Failsafe.failsafe { raise 'boom' }
      }.not_to raise_error
    end
  end

  context "when true" do
    before { Failsafe.disabled = true }

    it "allows errors to bubble up" do
      expect {
        Failsafe.failsafe { raise 'boom' }
      }.to raise_error
    end
  end
end

