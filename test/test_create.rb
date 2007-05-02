require 'test/unit'
$: << "#{File.expand_path(File.dirname(__FILE__))}/../lib"
require 'xulproject'

class TestCreate < Test::Unit::TestCase

	PROJECT_ROOT = "#{File.dirname(__FILE__)}/projects"

	def setup
		rm_rf PROJECT_ROOT
		mkdir_p PROJECT_ROOT
	end

	def test_create
		project = XULProject.new
		project.project_folder = PROJECT_ROOT
		project.name = "sample"
		project.create 
		projdir = "#{PROJECT_ROOT}/sample"
		assert File.exist?( projdir ), "Project failed to created"
		XULProject::TEMPLATES.each do|file|
			path = File.expand_path( "#{projdir}/#{file}" )
			assert File.exist?( path  ), "Failed to create file '#{file}'"
			assert_match /sample/i, File.read( path ), "Failed to find project name in '#{file}'"
		end
	end

end
