class Restaurant < ActiveRecord::Base
  belongs_to :address
  has_many :deals
  has_many :ratings, as: :ratingable
end
