require 'date'

class User < ActiveRecord::Base
  has_many :dogs
  has_many :walks
end
