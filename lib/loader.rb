require './lib/config'
require './test/test_helper'

# Loader loads
class Loader
  def self.load_all(file = Config::SAVE_FILE)
    if file.respond_to? :read
      YAML.load(file.read)
    else
      YAML.load(open(file).read)
    end
  end
end
