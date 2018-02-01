class Walk < ActiveRecord::Base
  belongs_to :user

  has_many :dog_walks
  has_many :dogs, through: :dog_walks

  include Slugifiable::Instance
  extend Slugifiable::Class
end
