require 'dotenv'

Dotenv.load

module Config
  YT_API_KEY = ENV['YT_API_KEY']
  YT_LOG_LEVEL = ENV['YT_LOG_LEVEL']

  SAVE_FILE = ENV['SAVE_FILE']
end
