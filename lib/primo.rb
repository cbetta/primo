require "parseconfig"

class Primo

  CONFIG_FILE = File.expand_path('~/.primo').freeze

  def self.create name, template
    system "rails new #{name} -m #{path_for(template)}"
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

  def self.path_for template
    return File.expand_path("templates/#{template}.rb") unless template =~ /\.rb$/i
    template
  end

  def self.ensure_config
    FileUtils.cp("data/.primo", CONFIG_FILE) unless File.exists?(CONFIG_FILE)
  end
end