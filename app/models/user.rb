class User < ActiveRecord::Base
  has_many :dogs
  has_many :walks, through: :dogs
end
