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
end