require './lib/config'

require 'yaml'

class Saver
  def self.save_all(all_series, file=Config::SAVE_FILE)
    if file.respond_to?(:write)
      file << YAML.dump(all_series)
    else 
      File.open(file, 'w') do |f|
        f.write(YAML.dump(all_series))
      end
    end
  end
end
