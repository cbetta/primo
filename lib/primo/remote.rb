class Primo
  class Remote
    DIRECTORY = File.expand_path('~/.primo_remotes').freeze

    def self.list
      Primo::Config.instance.config[:remotes]
    end

    attr_accessor :name, :url

    def initialize name, url = nil
      @name = name
      @url = url || Primo::Config.instance.config[:remotes][name]
      ensure_saved
    end

    def templates
      template_names.map {|name| Primo::Template.new(name, self)}
    end

    def update
      ensure_cloned
      system "cd #{directory}; git pull -q"
    end

    def remove
      Primo::Config.instance.config[:remotes].delete(name)
      Primo::Config.instance.save
      FileUtils.rm_rf directory
    end

    def directory
      "#{DIRECTORY}/#{name}"
    end

    def ensure_cloned
      unless File.exists? "#{directory}/.git"
        system "git clone #{url} #{directory} -q"
      end
    rescue
      raise "Could not load templates from #{url}"
    end

    private

    def ensure_saved
      if !Primo::Config.instance.config[:remotes][name] && url
        Primo::Config.instance.config[:remotes][name] = url
        Primo::Config.instance.save
      end
    end

    def template_names
      Dir.entries(directory).select do |filename|
        filename =~ /\.rb$/
      end
    end
  end
end