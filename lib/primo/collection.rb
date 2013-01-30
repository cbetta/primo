class Primo
  class Collection
    attr_accessor :name

    def initialize name
      @name = name
    end

    def templates
      template_filenames.map {|filename| Primo::Template.new(filename, self)}
    end

    def self.list
      Primo::Config.instance.config[:collections]
    end

    def self.add name, url
      Primo::Config.instance.config[:collections][name] = url
      Primo::Config.instance.save_config
      Primo::Git.new(name).update
    end

    def self.delete name
      Primo::Config.instance.config[:collections].delete(name)
      Primo::Config.instance.save_config
      Primo::Git.new(name).delete
    end

    private

    def template_filenames
      Dir.entries(Primo::Git.new(name).directory).select do |filename|
        filename =~ /\.rb$/
      end
    end
  end
end