require 'rake/testtask'

Rake::TestTask.new do |task|
  task.test_files = FileList['test/**/*_spec.rb']
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec

desc 'Run relentity console'
task :console do
  require 'irb'
  require_relative 'lib/relentity'
  include Relentity
  ARGV.clear
  IRB.start
end

task default: :spec
