require 'rake/testtask'

Rake::TestTask.new :spec do |task|
  task.test_files = FileList['spec/**/*_spec.rb']
end

desc 'Run relentity console'
task :console do
  require 'irb'
  require_relative 'lib/relentity'
  include Relentity
  ARGV.clear
  IRB.start
end

task default: :spec
