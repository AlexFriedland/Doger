class Dog < ActiveRecord::Base
  belongs_to :user

  has_many :dog_walks
  has_many :walks, through: :dog_walks
end
