require_relative 'init'
require 'rake/testtask'

desc "Run all tests"
Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
end

task default: %w[parse_file]
task :parse_file do
  file_path = ENV["file"]

  if file_path.nil?
    raise "File path should be provided: file=user.json"
  end

  Task.validate_file!(file_path)
  taks = Task.init_with_file_name(file_path)
  taks.run!

  puts "Done!"
end
