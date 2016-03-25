require 'rake'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |t|
  t.test_files = Dir.glob('test/*_test.rb')
end

RuboCop::RakeTask.new

task default: [:rubocop, :test]
