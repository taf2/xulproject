require 'erb'
require 'rubygems'
require 'uuidtools'
require 'active_support'

require 'fileutils'
include FileUtils

class XULProject
	TEMPLATE_ROOT = "#{File.dirname(__FILE__)}/../templates"
	TEMPLATES = [ "Rakefile", "application.ini", 
								"Info.plist", "defaults/preferences/prefs.js",
								"chrome/chrome.manifest"]

	def initialize
		@project_root = "."
		@version = "0.0.1"
	end

	def create
		project_path = "#{@project_root}/#{@name}"
		if File.exist? project_path
			raise "Project folder '#{File.expand_path(project_path)}' already exists!"
		end
		mkdir project_path

		@project_name = @name
		@vendor = @vendor || @name

		TEMPLATES.each do|template|
			input = "#{TEMPLATE_ROOT}/#{template}"
			output = "#{project_path}/#{template}"
			dirout = File.dirname(output)
			mkdir_p dirout unless File.exist?( dirout )
			puts "create file #{output}..."
			erb = ERB.new(File.read(input),0, "<>")
			File.open(output,"w") { |f| f.write( erb.result( self.get_binding ) ) }
		end

		ensure_exists "#{project_path}/chrome"
		ensure_exists "#{project_path}/components"
		ensure_exists "#{project_path}/defaults/preferences"
		cp_r "#{TEMPLATE_ROOT}/../tools", project_path

	end

	def ensure_exists(path)
		mkdir_p path unless File.exist?( path )
	end
	
	def name=( name )
		@name = name
		@name.gsub!(/\//,'_')
	end
	
	def vendor=( name )
		@vendor = name
		@vendor.gsub!(/\//,'_')
	end

	def version=( version )
		@version = version
	end

	def project_folder=( path )
		@project_root = path
	end
	
	def get_binding
		binding
	end

end
