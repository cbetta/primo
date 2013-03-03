require "spec_helper"

describe Primo::Remote do

  before :each do
    data = File.read("data/.primo")
    FakeFS.activate!
    FileUtils.mkdir_p "data"
    File.open("data/.primo", 'w') { |file| file.write(data) }
  end

  after :each do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end

  describe ".list" do
    it "should return the currently loaded remotes" do
      expect(Primo::Remote.list).to be == {"default"=>"git://github.com/cbetta/primo-templates.git"}
    end
  end

  describe "#initialize" do
    it "should save the remote in the config if it isn't already" do
      git_url = "git://github.com/cbetta/primo-templates.git"
      expect(Primo::Config.instance.config[:remotes]["test"]).to be_nil
      Primo::Remote.new("test", git_url)
      expect(Primo::Config.instance.config[:remotes]["test"]).to be == git_url
    end
  end

  describe "#templates" do
    before do
      remote = Primo::Remote::DIRECTORY + "/default"
      FileUtils.mkdir_p remote
      FileUtils.touch  "#{remote}/foobar.rb"
      FileUtils.touch  "#{remote}/barbaz.rb"
      FileUtils.touch  "#{remote}/README.md"
    end

    it "should return a list of templates for the remote" do
      templates = Primo::Remote.new("default").templates
      expect(templates).to have(2).templates
      templates.each do |template|
        expect(["foobar", "barbaz"]).to include(template.name)
      end
    end
  end

  describe "#update" do
    it "should only update the repo the second time" do
      remote = Primo::Remote.new("default")
      File.should_receive(:exists?).and_return(true)
      remote.should_receive("system").once
      remote.update
    end

    it "should clone the repo on first load" do
      remote = Primo::Remote.new("default")
      remote.should_receive("system").twice
      remote.update
    end
  end

  describe "#remove" do
    it "should remove the cloned repo" do
      remote = Primo::Remote.new("default")
      FileUtils.should_receive(:rm_rf).with(remote.directory)
      remote.remove
    end

    it "should remove the remote from the config" do
      remote = Primo::Remote.new("default")
      FileUtils.stub(:rm_rf)
      remote.remove
      expect(Primo::Remote.list).to be_empty
    end
  end
end
