class Breed < ApplicationRecord
    validates :name, presence: true
    validates :breed_id, presence: true
    validates :rarity, numericality: { greater_than_or_equal_to: 0, less_than: 6 } 

    scope :ordered, -> { order(:name) }
end
