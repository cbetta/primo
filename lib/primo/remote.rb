class Primo
  class Remote
    COLLECTIONS_DIR = File.expand_path('~/.primo_collections').freeze

    def self.list
      Primo::Config.instance.config[:remotes]
    end

    attr_accessor :name, :url

    def initialize name, url = nil
      @name = name
      @url = url || Primo::Config.instance.config[:remotes][name]

      unless Primo::Config.instance.config[:remotes][name]
        Primo::Config.instance.config[:remotes][name] = url
        Primo::Config.instance.save
      end
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
      "#{COLLECTIONS_DIR}/#{name}"
    end

    private

    def ensure_cloned
      unless File.exists? "#{directory}/.git"
        system "git clone #{url} #{directory} -q"
      end
    rescue
      # try next time
    end

    def template_names
      Dir.entries(directory).select do |filename|
        filename =~ /\.rb$/
      end
    end
  end
end