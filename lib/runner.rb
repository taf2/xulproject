require 'ostruct'
require 'optparse'
require 'xulproject'


option_values = OpenStruct.new

options = OptionParser.new do |opts|
	opts.banner = "Usage: #{$0} project_name [options]"
	opts.on( "-b S", "--vendor", "Vendor Name" ){|vendor| option_values.vendor = vendor }
	opts.on( "-m S", "--version", "Application version" ) { |version| option_values.version = version }
	opts.on( "-p S", "--project_root", "Project Root Folder" ) { |root| option_values.root = root }
	opts.on_tail("-h", "--help", "Show this message") {
		puts opts
		exit
	}
end

project_name = ARGV[0]

if !project_name
	puts "Project name is required!"
	puts options.help
	exit 1
end
options.parse!

proj = XULProject.new

proj.project_folder = option_values.root if option_values.root

proj.name = project_name 

proj.create
