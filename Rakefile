require 'rubygems'
require 'i18n'
require 'active_support'
require 'rake/dsl_definition'

# Set up gems listed in the Gemfile.
gemfile = File.expand_path('../Gemfile', __FILE__)
begin
  ENV['BUNDLE_GEMFILE'] = gemfile
  require 'bundler'
  Bundler.setup
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!
end if File.exist?(gemfile)

Bundler.require

Gemstub.test_framework = :rspec

Gemstub.gem_spec do |s|
  s.version = '1.1.0'
  # s.rubyforge_project = 'snooze_force'
  s.add_dependency('httparty')
  s.add_dependency('i18n')
  s.add_dependency('activesupport', '>=3.0.0')
  # s.email = ''
  # s.homepage = ''
end

Gemstub.rdoc do |rd|
  rd.title = 'snooze_force'
end
