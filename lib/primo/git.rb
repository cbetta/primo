require "git"

class Primo
  class Git

    def initialize name
      @name = name
    end

    def update
      print "Updating #{@name} template collection..."
      ensure_cloned
      system "cd #{directory}; git pull -q"
      puts "\tupdated"
    end

    def delete
      FileUtils.rm_rf directory
    end

    def directory
      "#{COLLECTIONS_DIRECTORY}/#{@name}"
    end

    private

    COLLECTIONS_DIRECTORY = File.expand_path('~/.primo_collections').freeze

    def ensure_cloned
      unless File.exists? "#{directory}/.git"
        system "git clone #{url} #{directory} -q"
      end
    rescue

    end

    def url
      Primo::Config.instance.config[:collections][@name]
    end
  end
end