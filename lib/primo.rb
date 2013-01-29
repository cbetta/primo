require "parseconfig"

class Primo

  CONFIG_FILE = File.expand_path('~/.primo').freeze

  def self.create name
    system "rails new #{name} -m #{current_template_path}"
  end

  def self.default value
    ensure_config
    File.write CONFIG_FILE, File.read(CONFIG_FILE)
      .gsub(/^default *= *\S*/m, "default = '#{value}'")
  end

  def self.current_template
    ensure_config
    ParseConfig.new(CONFIG_FILE)["default"]
  end

  def self.current_template_path
    default = current_template
    default = File.expand_path("templates/#{default}.rb") unless default =~ /\.rb$/i
    default
  end

  def self.ensure_config
    FileUtils.cp("data/.primo", CONFIG_FILE) unless File.exists?(CONFIG_FILE)
  end
end