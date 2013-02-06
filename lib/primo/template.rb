class Primo
  class Template

    attr_accessor :filename, :remote

    def self.for display_name
      remote_name, name = display_name.split("-")
      remote = Primo::Remote.new(remote_name)
      filename = "#{name}.rb"
      Primo::Template.new filename, remote
    end

    def self.list
      Primo::Remote.list.map do |name, url|
        Primo::Remote.new(name).templates
      end.flatten
    end

    def self.exists? display_name
      Primo::Template.list.map{|tp| tp.display_name}.include? display_name
    end

    def self.default
      Primo::Config.instance["default"]
    end

    def self.default= value
      raise ArgumentError, "No such template found" unless Primo::Template.exists?(value)
      Primo::Config.instance["default"] = value
    end

    def initialize filename, remote
      @filename = filename
      @remote = remote
    end

    def display_name
      "#{remote.name}-#{name}"
    end

    def name
      filename[0..-4]
    end

    def expanded_filename
      "#{Primo::Remote::DIRECTORY}/#{remote.name}/#{filename}"
    end

    def read
      File.read(expanded_filename)
    end
  end
end