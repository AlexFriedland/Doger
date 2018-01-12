class Walk < ActiveRecord::Base
  has_many :dogs
  belongs_to :user
end
