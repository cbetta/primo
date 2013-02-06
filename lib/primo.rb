require "primo/version"
require "primo/config"
require "primo/remote"
require "primo/creator"
require "primo/template"
require 'rbconfig'


class Primo
  def self.void
    void ||= RbConfig::CONFIG['host_os'] =~ /msdos|mswin|djgpp|mingw/ ? 'NUL' : '/dev/null'
  end

  def self.ensure_git_installed
    return if system "git --version >>#{self.void} 2>&1"
    puts "Please install Git before continuing"
    exit(1)
  end

  def self.ensure_rails_installed
    return if system "git --version >>#{self.void} 2>&1"
    puts "Please install Rails before continuing"
    exit(1)
  end

  def self.ensure_ininial_remote_pulled
    unless Primo::Config.instance["post-install-processed"]
      raise "No template collections specified in ~/.primo" unless self.initial_collection
      Primo::Remote.new(self.initial_collection).update
      Primo::Config.instance["post-install-processed"] = true
    end
  end

  def self.initial_collection
    @config[:remotes].keys.first
  rescue
    nil
  end
end