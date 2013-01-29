require "singleton"
require "inifile"

class Primo
  class Config
    include Singleton

    attr_accessor :config

    def initialize
      @config = load_config
    end

    def [] key
      @config["global"][key]
    end

    def []= key,value
      @config["global"][key] = value
      save_config
    end

    def save_config
      @config.write
    end

    private

    CONFIG_FILE = File.expand_path('~/.primo').freeze

    def load_config
      ensure_config
      IniFile.new(filename: CONFIG_FILE)
    end

    def ensure_config
      FileUtils.cp("data/.primo", CONFIG_FILE) unless File.exists?(CONFIG_FILE)
    end
  end
end