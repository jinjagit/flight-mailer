class Airport < ApplicationRecord
  has_many :flights_from, class_name: 'Flight', foreign_key: 'from_id'
  has_many :flights_to, class_name: 'Flight', foreign_key: 'to_id'
end
