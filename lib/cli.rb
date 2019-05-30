# frozen_string_literal: true

require_relative '../config/environment'
require 'pry'

class CommandLineInterface
  def initialize
    @current_user = nil
  end


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
    user_options
  end

  def user_options
    puts "_____________"
    puts 'What would you like to do next?'
    puts "_____________"
    puts "Search through Apps? Type 'choose_app'"
    puts "Review an App? Type 'review_app'"
    puts "Check your reviews by typing 'my_reviews'"
    puts "Search reviews per App by typing 'find_reviews'"
    response = gets.chomp
      if response == 'choose_app'
        choose_app
      elsif response == 'review_app'
        review_app
      elsif response == 'my_reviews'
        my_reviews
      elsif response == 'find_reviews'
        find_reviews
      end

  end

  def review_app
    new_review = Review.new
    puts "Type the name of the App you'd like to review"
    app_choice = gets.chomp
    puts "You have chosen to review #{app_choice}"
    puts "Please write your review"
    new_review_content = gets.chomp
    puts "Please give a rating beween 1 and 5"
    new_review_rating = gets.chomp
    puts "This is what you've submitted so far"
    puts app_choice
    puts new_review_content
    puts "Rating: #{new_review_rating}"
    puts "Would you like to save this review?"
    response = gets.chomp
    if response == 'Y'
      new_review.content = new_review_content
      new_review.rating = new_review_rating
      new_review.user_id = @current_user.id
      new_review.app_id = App.find_by_name(app_choice).id
      new_review.save
      puts 'Your review has been saved!'
    else
      puts 'Lets try again'
      review_app
    end
    user_options
  end

def find_reviews
  puts "Which app's reviews would you like to check?"
  response = gets.chomp
  app_choice = App.find_by_name(response)


  current_reviews = Review.where(app_id: app_choice.id)
  puts "_______"
  puts app_choice.name
  print "Average Rating: #{app_choice.avg_rating}"
  puts " "
  puts "_______"


  current_reviews.map do |review|
    User.all.select do |t|
      if t.id == review.user_id
    puts " "
    print "Review: "
    print review.content
    print " | "
    print "Rating: "
    print review.rating
    print " | "
    print "User: "

      puts t.name
    end
    end
    puts " "
    puts " "

  end


end


def debug?
  puts "Do you want to debug?"
  response = gets.chomp
  if response == 'Y'
    user_options
  else
    puts "Let's carry on then"
    new_user
  end
end

  def new_user
    @current_user = User.new
    puts 'Please enter your name'
    new_name = gets.chomp
    puts 'Please enter your email'
    new_email = gets.chomp
    @current_user.name = new_name
    @current_user.email = new_email
    puts 'This is the information you entered? Input Y for yes and N for no'
    puts @current_user.name
    puts @current_user.email
    puts 'Is this correct?'
    response = gets.chomp
    if response == 'Y'
      @current_user.save
      puts 'Your information has been saved!'
    else
      puts 'Please try again'
      new_user
  end
    user_options
end
end
