require "primo"
require "fakefs/safe"

RSpec.configure do |config|
  config.before :each do
    data = File.read("data/.primo")
    FakeFS.activate!
    FileUtils.mkdir_p "data"
    File.open("data/.primo", 'w') { |file| file.write(data) }
  end

  config.after :each do
    FakeFS::FileSystem.clear
    FakeFS.deactivate!
  end
end