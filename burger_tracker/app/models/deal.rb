class Deal < ActiveRecord::Base
  belongs_to :restaurant
  has_many :burger_deals
  has_many :ratings, as: :ratingable
  has_many :burgers, through: :burger_deals, source: :burger
end
