require 'rubygems'
require 'bundler'

require File.expand_path('../lib/declension/version', __FILE__)

begin
  Bundler.setup :default, :development
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts 'Run `bundle install` to install missing gems'
  exit e.status_code
end

require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  gem.name = 'declension'
  gem.homepage = 'http://github.com/miks/declension'
  gem.license = 'MIT'
  gem.summary = 'Apply grammatical cases to words'
  gem.description = 'Apply grammatical cases to words.'
  gem.email = 'miks.mikelsons@gmail.com'
  gem.version = Declension::VERSION
  gem.authors = ['Miks Mikelsons']
  gem.files = Dir.glob('lib/**/*')
end

Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) { |spec| spec.pattern = FileList['spec/**/*_spec.rb'] }

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ''

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "declension #{version}"
  rdoc.rdoc_files.include 'README*'
  rdoc.rdoc_files.include 'LICENSE*'
  rdoc.rdoc_files.include 'lib/**/*.rb'
end
