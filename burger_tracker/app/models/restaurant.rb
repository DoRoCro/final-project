class Restaurant < ActiveRecord::Base
  belongs_to :address
  has_many :deals
end
