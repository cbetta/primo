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