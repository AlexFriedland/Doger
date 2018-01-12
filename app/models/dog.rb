class Dog < ActiveRecord::Base
  belongs_to :user
  has_many :walks
end
