require "spec_helper"

describe Primo::Creator do


  describe "#create" do
    it "should create a rails install with the given name and template" do
      creator = Primo::Creator.new("foo-bar")
      creator.template.remote.stub(:system)
      creator.should_receive(:system).with(/rails new my_app -m .*foo\/bar.rb/)
      creator.create("my_app")
    end
  end

end
