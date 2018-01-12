class Dog < ActiveRecord::Base
  belongs_to :user
  
  belongs_to :walk
  has_many :walks
end
