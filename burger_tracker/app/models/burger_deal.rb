class BurgerDeal < ActiveRecord::Base
  belongs_to :burger
  belongs_to :deal
end
