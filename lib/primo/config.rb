require "singleton"
require "inifile"

class Primo
  class Config
    CONFIG_FILE = File.expand_path('~/.primo').freeze

    attr_accessor :config

    def self.instance
      ensure_dot_file_created
      @instance ||= Primo::Config.new
    end

    def initialize
      load_config
    end

    def [] key
      @config["global"][key]
    end

    def []= key,value
      @config["global"][key] = value
      save
    end

    def save
      @config.write
    end

    def check_post_install
      unless self["post-install-processed"]
        raise "No template collections specified in ~/.primo" unless initial_collection
        Primo::Remote.new(initial_collection)
        self["post-install-processed"] = true
      end
    end

    private

    def load_config
      @config ||= IniFile.new(filename: CONFIG_FILE)
    end

    def self.ensure_dot_file_created
      unless File.exists?(CONFIG_FILE)
        FileUtils.cp("data/.primo", CONFIG_FILE)
        @instance = nil
      end
    end

    def initial_collection
      @config[:remotes].keys.first
    rescue
      nil
    end
  end
end