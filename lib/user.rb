class User < ActiveRecord::Base
  has_many :apps
  has_many :apps, through: :reviews
end
