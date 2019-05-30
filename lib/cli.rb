# frozen_string_literal: true

require_relative '../config/environment'
require 'pry'

class CommandLineInterface
  @@user = nil

  def greet
    puts 'Welcome to the App Review program, Enjoy!'
  end

  def choose_app
    puts "If you have a specific app in mind, input it's name."
    puts "Otherwise, see all apps available by typing 'list_all'"
    # app_arr = []
    # test = App.all.select {|app| app.name}
    # test_2 =  test.map {|test| test.name}
    #
    # puts test_2
    app_request = gets.chomp
    if app_request == 'list_all'
      test = App.all.select do |app|
        print 'ID = '
        print app.id
        print ', '
        print 'Name = '
        print app.name
        print ', '
        print 'Category = '
        print app.category
        puts ' '
      end
      test_2 = test.map do |test|
        print 'ID = '
        print test.id
        print ', '
        print 'Name = '
        print test.name
        print ', '
        print 'Category = '
        print test.category
        puts ' '
      end

      # puts test_2
      # puts ""
      # puts "Please choose an app and input it's name"
      # found_app_request = gets.chomp
      # found_app_redux = App.find_by_name(found_app_request)
      # print 'ID = '
      # print found_app_redux.id
      # print ', '
      # print 'Name = '
      # print found_app_redux.name
      # print ', '
      # print 'Category = '
      # print found_app_redux.category
      # puts ' '
    elsif found_app = App.find_by_name(app_request)
      print 'ID = '
      print found_app.id
      print ', '
      print 'Name = '
      print found_app.name
      print ', '
      print 'Category = '
      print found_app.category
      puts ' '
    else
      puts 'Invalid input, try again!'
      choose_app
    end
  end

  def user_options
    puts 'What would you like to do next?'
    puts "Search through Apps? Type 'choose_app'"
    response = gets.chomp
    choose_app if response == 'choose_app'
  end

  def new_user
    current_user = User.new
    puts 'Please enter your name'
    new_name = gets.chomp
    puts 'Please enter your email'
    new_email = gets.chomp
    current_user.name = new_name
    current_user.email = new_email
    puts 'This is the information you entered? Input Y for yes and N for no'
    puts current_user.name
    puts current_user.email
    puts 'Is this correct?'
    response = gets.chomp
    if response == 'Y'
      current_user.save
      puts 'Your information has been saved!'
    else
      puts 'Please try again'
      new_user
  end
    user_options
end
end
