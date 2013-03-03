require "spec_helper"

describe Primo::Config do

  describe ".instance" do
    it "should create the config file when needed" do
      Primo::Config.instance
      expect(File.exists?(Primo::Config::CONFIG_FILE)).to be_true
    end

    it "should not create the config file twice" do
      Primo::Config.instance
      created_at = File.new(Primo::Config::CONFIG_FILE).mtime
      Primo::Config.instance
      expect(File.new(Primo::Config::CONFIG_FILE).mtime).to be == created_at
    end
  end

  describe "#[]" do
    it "should return the right value" do
      Primo::Config.instance["foo"] = "bar"
      expect(Primo::Config.instance["foo"]).to be == "bar"
    end
  end

  describe "#[]=" do
    it "should save the config to file" do
      Primo::Config.instance
      created_at = File.new(Primo::Config::CONFIG_FILE).mtime
      Primo::Config.instance["foo"] = "bar"
      expect(File.new(Primo::Config::CONFIG_FILE).mtime).not_to be == created_at
    end
  end

  describe "#save" do
    it "should save the config to file" do
      Primo::Config.instance
      created_at = File.new(Primo::Config::CONFIG_FILE).mtime
      Primo::Config.instance.save
      expect(File.new(Primo::Config::CONFIG_FILE).mtime).not_to be == created_at
    end
  end
end