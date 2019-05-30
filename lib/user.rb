class User < ActiveRecord::Base
  has_many :apps
  has_many :apps, through: :reviews

  # current_user = User.new
  #
  # def new_user
  #   puts "Please enter your name"
  #   new_name = gets.chomp
  #   puts "Please enter your email"
  #   new_email = gets.chomp
  #   current_user.name = new_name
  #   current_user.email = new_email
  #   puts "This is the information you entered? Input Y for yes and N for no"
  #   puts current_user
  #   puts "Is this correct?"
  #   response = gets.chomp
  #   if gets.chomp == "Y"
  #     current_user.save
  #   else
  #     puts "Please try again"
  #     new_user
  # end
# end



end
