class Review < ActiveRecord::Base
  belongs_to :home
  belongs_to :user
end