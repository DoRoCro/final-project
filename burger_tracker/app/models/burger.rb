class Burger < ActiveRecord::Base
  belongs_to :restaurant
  has_many :deals, through: :burger_deals, source: :deal
end
