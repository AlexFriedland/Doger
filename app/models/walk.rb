class Walk < ActiveRecord::Base
  belongs_to :dog
  belongs_to :user

  include Slugifiable::Instance
  extend Slugifiable::Class
end
