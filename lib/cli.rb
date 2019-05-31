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

    puts "See all apps available by typing 'list'"
    puts " "
    # app_arr = []
    # test = App.all.select {|app| app.name}
    # test_2 =  test.map {|test| test.name}
    #
    # puts test_2
    app_request = gets.chomp
    if app_request == 'list'
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

    else
      puts 'Invalid Input, Try Again!'
      choose_app
    end
    puts " "
    puts "If you'd like to search for reviews, Type 'Search Reviews'"
    puts " "
    response2 = gets.chomp
    if response2 == 'Search Reviews'
      find_reviews
    else
      puts "Invalid Input, You are being returned to the main menu"
    user_options
  end
  end

  def user_options
    puts '_____________'
    puts 'What would you like to do next?'
    puts '_____________'
    puts "Search Options"
    puts "===="
    puts "Search through Apps? Type 'Search Apps'"
    puts "Search reviews per App by typing 'Search Reviews'"
    puts " "
    puts "User Options"
    puts "===="
    puts "Review an App? Type 'New Review'"
    puts "Check your reviews by typing 'My Reviews'"
    puts "Edit a review with 'Change Review'"
    puts "Delete a review with 'Delete Review'"
    puts " "

    menu_selection

  end

  def menu_selection
    response = gets.chomp
    if response == 'Search Apps'
      choose_app
    elsif response == 'New Review'
      review_app
    elsif response == 'My Reviews'
      my_reviews
    elsif response == 'Search Reviews'
      find_reviews
    elsif response == 'Change Review'
      change_review
    elsif response == 'Delete Review'
      delete_review
    else puts "Invalid Input, Try Again!"
      menu_selection

    end

  end

  def review_app
    app_rating_total = []
    new_review = Review.new
    puts "Type the name of the App you'd like to review"
    app_choice = gets.chomp
  #   if App.all.name.to_s.include?(app_choice)
    current_app = App.find_by_name(app_choice)
  # else
  #   puts "Invalid Input, Try Again"
  #   review_app
  # end

    puts "You have chosen to review #{app_choice}"
    puts 'Please write your review'
    new_review_content = gets.chomp
    puts 'Please give a rating beween 1 and 5'
    new_review_rating = gets.chomp
    puts "This is what you've submitted so far"
    puts "+++++++"
    puts app_choice
    puts " "
    puts new_review_content
    puts " "
    puts "Rating: #{new_review_rating}"
    puts "+++++++"
    puts " "
    puts "Would you like to save this review? Type 'Y' for yes"
    puts "Press any other key and press 'Enter' to try again"
    response = gets.chomp
    if response == 'Y'
      new_review.content = new_review_content
      new_review.rating = new_review_rating
      new_review.user_id = @current_user.id
      new_review.app_id = current_app.id
      new_review.save

      # update User Records
      @current_user.app_id = new_review.app_id
      @current_user.review_id = new_review.id

      # update App Records
      current_app.user_id = @current_user.id
      current_app.review_id = new_review.id

      # update total review count in Apps
      current_app.total_reviews += 1

      # update avg rating in Apps
      Review.all.select do |review|
        app_rating_total << review.rating if review.app_id == new_review.app_id
      end

      new_avg = app_rating_total.sum / app_rating_total.size

      current_app.avg_rating = new_avg
      current_app.save

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
  #   if App.all.name.to_s.include?(app_choice)
    current_app = App.find_by_name(app_choice)
  # else
  #   puts "Invalid Input, Try Again"
  #   find_reviews
  # end

    current_reviews = Review.where(app_id: app_choice.id)
    puts '_______'
    print 'ID = '
    print app_choice.id
    puts " "
    puts app_choice.name
    puts " "
    print "Category: "
    print app_choice.category
    puts " "
    print "Average Rating: #{app_choice.avg_rating}"
    puts ' '
    puts '_______'

    current_reviews.map do |review|
      User.all.select do |t|
        next unless t.id == review.user_id

        puts ' '
        print 'Review: '
        print review.content
        print ' | '
        print 'Rating: '
        print review.rating
        print ' | '
        print 'User: '

        puts t.name
      end
      puts ' '
      puts ' '
    end
    puts "Press any key and press 'Enter' to return to the Main Menu"
    gets.chomp
    user_options
  end

  def my_reviews
    puts '------------'
    puts 'Here are your reviews'
    puts '------------'
    Review.all.map do |review|
      next unless review.user_id == @current_user.id

      App.all.select do |t|
        next unless t.id == review.app_id

        puts ' '
        print 'App: '
        print t.name
        print ' | '
        print 'Review: '
        print review.content
        print ' | '
        print 'Rating: '
        print review.rating
        puts ' '
        puts ' '
      end
    end
    puts "Press any key and press 'Enter' to return to the Main Menu"
    gets.chomp
    user_options
  end

  def change_review
    puts '------------'
    puts 'Here are your reviews'
    puts '------------'
    Review.all.map do |review|
      next unless review.user_id == @current_user.id

      App.all.select do |t|
        next unless t.id == review.app_id

        puts ' '
        print 'App: '
        print t.name
        print ' | '
        print 'Review: '
        print review.content
        print ' | '
        print 'Rating: '
        print review.rating
        puts ' '
        puts ' '
      end
    end
    puts '------------'
    puts 'Which review would you like to change?'
    puts 'Please enter the App name'
  #   if App.all.name.to_s.include?(app_choice)
    # current_app = App.find_by_name(app_choice)
  # else
  #   puts "Invalid Input, Try Again"
  #   change_review
  # end

    app_rating_total = []
    new_review = Review.new
    app_choice = gets.chomp
    current_app = App.find_by_name(app_choice)

    Review.all.select do |review|
      review.destroy if (review.id == @current_user.review_id && review.app_id == current_app.id)

    end
    puts "____"
    puts "You have chosen to change your review for #{app_choice}"
    puts 'Please write your review'
    new_review_content = gets.chomp
    puts 'Please give a rating beween 1 and 5'
    new_review_rating = gets.chomp
    puts "This is what you've submitted so far"
    puts "+++++++"
    puts app_choice
    puts " "
    puts new_review_content
    puts " "
    puts "Rating: #{new_review_rating}"
    puts "+++++++"
    puts " "
    puts "Would you like to save this review? Type 'Y' for yes"
    puts "Press any other key and press 'Enter' to try again"
    response = gets.chomp
    if response == 'Y'
      new_review.content = new_review_content
      new_review.rating = new_review_rating
      new_review.user_id = @current_user.id
      new_review.app_id = current_app.id
      new_review.save

      # update User Records
      @current_user.app_id = new_review.app_id
      @current_user.review_id = new_review.id

      # update App Records
      current_app.user_id = @current_user.id
      current_app.review_id = new_review.id

      # update total review count in Apps
      current_app.total_reviews += 1

      # update avg rating in Apps
      Review.all.select do |review|
        app_rating_total << review.rating if review.app_id == new_review.app_id
      end

      new_avg = app_rating_total.sum / app_rating_total.size

      current_app.avg_rating = new_avg
      current_app.save

      puts 'Your review has been saved!'

    else
      puts 'Lets try again'
      change_review
    end
    puts "Press any key and press 'Enter' to return to the Main Menu"
    gets.chomp
    user_options
  end

  def delete_review
    app_rating_total = []
    puts '------------'
    puts 'Here are your reviews'
    puts '------------'
    Review.all.map do |review|
      next unless review.user_id == @current_user.id

      App.all.select do |t|
        next unless t.id == review.app_id

        puts ' '
        print 'App: '
        print t.name
        print ' | '
        print 'Review: '
        print review.content
        print ' | '
        print 'Rating: '
        print review.rating
        puts ' '
        puts ' '
      end
    end
    puts '------------'
    puts 'Which review would you like to delete?'
    puts 'Please enter the App name'
    # if App.all.name.to_s.include?(app_choice)
    # current_app = App.find_by_name(app_choice)
    # else
    # puts "Invalid Input, Try Again"
    # delete_review
    # end


    app_choice = gets.chomp
    current_app = App.find_by_name(app_choice)
    puts "Your '#{app_choice}' review is being deleted'"
    puts ' '
    Review.all.select do |review|
      review.destroy if (review.id == @current_user.review_id && review.app_id == current_app.id)

    end
    current_app.total_reviews -= 1
    Review.all.select do |review|
      app_rating_total << review.rating if review.app_id == current_app.id
    end
    current_app.save
    puts ' '
    puts 'Your review was deleted successfully'
    puts " "
    puts "Press any key and press 'Enter' to return to the Main Menu"
    gets.chomp
    puts ' '

    user_options
  end

  def debug?
    puts 'Do you want to debug?'
    response = gets.chomp
    if response == 'Y'
      user_options
    else
      puts "Let's carry on then"
      new_user
    end
  end

  def existing_user
    puts "Please enter your name"
    name_req = gets.chomp

    User.all.each do |user|
      if user.name == name_req
        @current_user = user
      end
    end


    if @current_user == nil

      puts "Not valid, Try again"
      new_user
    else
      user_options
    end
  end

  def new_user
    puts "Are you an existing user?"
    puts "Input 'Y' for yes and 'N' for no"
    response2 = gets.chomp
    if response2 == 'Y'
      existing_user

    end

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
