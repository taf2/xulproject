require 'rake'
require 'rake/testtask'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'tools/rakehelp'
require 'fileutils'
require 'zlib'
include FileUtils

setup_tests
setup_clean ["pkg", "*.gem", "doc/site/output", ".config"]
setup_rdoc ['README', 'doc/**/*.rdoc']

name="xulproject"
version="0.0.1"

task :default => [:test]

task :package => [:clean,:test,:rerdoc]

setup_gem(name, version) do |spec|
  spec.summary = "A simple packaging, development, and testing environment for xulrunner applications"
  spec.description = spec.summary
  spec.test_files = Dir.glob('test/test_*.rb')
  spec.author="Todd A. Fisher"
  spec.executables=['xulproject']
  spec.files += %w(README Rakefile setup.rb)

  spec.required_ruby_version = '>= 1.8.4'
end

task :install do
  sh %{rake package}
  sh %{gem install pkg/xulproject-#{version}}
end

task :uninstall => [:clean] do
  sh %{gem uninstall xulproject}
end

