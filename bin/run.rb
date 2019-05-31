require_relative '../config/environment'

puts "Your Program is Launching..."

cli = CommandLineInterface.new
cli.greet
cli.new_user
