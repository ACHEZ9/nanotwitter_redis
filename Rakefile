require './app'
require 'sinatra/activerecord/rake'
require 'rake/testtask'

task :default => 'test:all'

Rake::TestTask.new do |test|
    test.name = 'test:all'
    test.verbose = true
    test.warning = true
    test.test_files = FileList['./test/*spec.rb']
end
