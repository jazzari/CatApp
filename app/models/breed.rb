class Breed < ApplicationRecord
    validates :name, presence: true
    validates :breed_id, presence: true
    validates :rarity, numericality: { greater_than_or_equal_to: 0, less_than: 6 } 
    has_many :cats

    scope :ordered, -> { order(:name) }
    scope :filter_by_rarity, -> (rarity) { where rarity: rarity }
    scope :filter_by_name, -> (name) { where("name like ?", "#{name}%")}
end
