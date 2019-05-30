# frozen_string_literal: true

require 'pry'

class CommandLineInterface
  @@user = nil
  def greet
    puts 'Welcome to the App Review program, Enjoy!'

  end



  def choose_app
    puts "If you have a specific app in mind, input it's name."
      puts "Otherwise, see all apps available by typing 'list_all"
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
      test_2 =  test.map do |test|
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
end
