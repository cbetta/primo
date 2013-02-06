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

  describe "#check_post_install" do
    it "on first use it should pull the primo templates" do
      expect(Primo::Config.instance["post-install-processed"]).to be_nil
      Primo::Remote.should_receive(:new).with("default")
      Primo::Config.instance.check_post_install
      expect(Primo::Config.instance["post-install-processed"]).to be_true
    end

    it "should only pull the templates in twice" do
      Primo::Config.instance["post-install-processed"] = true
      Primo::Remote.should_not_receive(:new)
      Primo::Config.instance.check_post_install
    end
  end

end