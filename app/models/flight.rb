class Flight < ApplicationRecord
  belongs_to :to, class_name: 'Airport', foreign_key: 'to_id'
  belongs_to :from, class_name: 'Airport', foreign_key: 'from_id'
end
