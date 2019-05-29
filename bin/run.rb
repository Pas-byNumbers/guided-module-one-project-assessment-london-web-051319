require_relative '../config/environment'

puts "run.rb has been executed"

cli = CommandLineInterface.new
cli.greet
cli.choose_app
