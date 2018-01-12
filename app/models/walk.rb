class Walk < ActiveRecord::Base
  belongs_to :dog
  belongs_to :user
  has_many :dogs

  include Slugifiable::Instance
  extend Slugifiable::Class
end
