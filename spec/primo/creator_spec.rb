require "spec_helper"

describe Primo::Creator do


  describe "#create" do
    before :each do
      Primo::Template.stub(:list).and_return([Primo::Template.for("default-rails")])
    end

    it "should create a rails install with the given name and template" do
      creator = Primo::Creator.new("default-rails")
      creator.template.remote.stub(:system)
      creator.should_receive(:system).with(/rails new my_app -m .*default\/rails.rb/)
      creator.create("my_app")
    end

    it "should ensure the template exists" do
      creator = Primo::Creator.new("foo-bar")
      expect(->{creator.create("my_app")}).to raise_error(ArgumentError)
    end
  end

end
