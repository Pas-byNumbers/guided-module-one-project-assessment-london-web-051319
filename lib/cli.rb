# frozen_string_literal: true
require 'pry'

class CommandLineInterface
  def greet
    puts 'Welcome to the App Review program, Enjoy!'
  end

  def choose_app
    puts 'Which app would you like to check?'

    app_request = gets.chomp

    output = App.find_by_name(app_request.to_s)

    puts output

  end
end
