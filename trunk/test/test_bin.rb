require 'test/unit'
require 'fileutils'
include FileUtils

class TestBin < Test::Unit::TestCase

	PROJECT_ROOT = "#{File.dirname(__FILE__)}/projects"

	def setup
		puts "setup"
		rm_rf PROJECT_ROOT
		mkdir_p PROJECT_ROOT
	end

	def test_binary
		puts `ruby test/bin.rb sample -p #{PROJECT_ROOT}`
		assert File.exist?( "#{PROJECT_ROOT}/sample" ), "Failed to create project!"
	end

end
