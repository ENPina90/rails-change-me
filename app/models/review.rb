class Review < ApplicationRecord
  belongs_to :location

  validates :rating, presence: true
end
