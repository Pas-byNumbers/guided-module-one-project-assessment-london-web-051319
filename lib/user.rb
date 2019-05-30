class User < ActiveRecord::Base
  has_many :apps
  has_many :apps, through: :reviews

  def new_user
    puts "Please enter your name"
    new_name = gets.chomp
    User.new(name: new_name)
  end

end
