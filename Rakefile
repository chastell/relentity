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
