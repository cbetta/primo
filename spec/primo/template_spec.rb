require "spec_helper"

describe Primo::Template do

  describe ".for" do
    it "should initialize a template with the right name and remote" do
      template = Primo::Template.for "foo-bar"
      expect(template.filename).to be == "bar.rb"
      expect(template.remote.name).to be == "foo"
    end
  end

  describe ".list" do
    it "should return a list of templates for every configured remote" do
      FileUtils.mkdir_p("#{Primo::Remote::DIRECTORY}/default")
      FileUtils.touch "#{Primo::Remote::DIRECTORY}/default/foobar.rb"
      FileUtils.mkdir_p("#{Primo::Remote::DIRECTORY}/foo")
      FileUtils.touch "#{Primo::Remote::DIRECTORY}/foo/bar.rb"
      Primo::Config.instance.config[:remotes]["foo"] = "some_url"
      expect(Primo::Template.list).to have(2).item
    end
  end

  context "with an instance" do

    before :each do
      @template = Primo::Template.new "bar.rb", Primo::Remote.new("foo")
    end

    describe "#initialize" do
      it "should set the filename and the remote" do
        expect(@template.filename).to be == "bar.rb"
        expect(@template.remote.name).to be == "foo"
      end
    end

    describe "#display_name" do
      it "should return the display name" do
        expect(@template.display_name).to be == "foo-bar"
      end
    end

    describe "#name" do
      it "should return the template name" do
        expect(@template.name).to be == "bar"
      end
    end

    describe "#expanded_filename" do
      it "should return the template's full filename" do
        expect(@template.expanded_filename).to be == File.expand_path("~/.primo_remotes/foo/bar.rb")
      end
    end

    describe "#default" do
      before do
        Primo::Template.should_receive(:list).and_return([Primo::Template.for("default-rails")])
      end

      it "should set the default" do
        expect(Primo::Template.default).not_to be == "default-rails"
        Primo::Template.default = "default-rails"
        expect(Primo::Template.default).to be == "default-rails"
      end

      it "should error if the default template doesn't exist" do
        expect(-> {Primo::Template.default = "default-foo"}).to raise_error(ArgumentError)
      end
    end

    describe "#read" do

      before do
        FileUtils.mkdir_p("#{Primo::Remote::DIRECTORY}/#{@template.remote.name}")
        File.open(@template.expanded_filename, 'w') { |file| file.write("FOOBAR") }
      end

      it "should return the template content" do
        expect(@template.read).to be == "FOOBAR"
      end
    end
  end
end
