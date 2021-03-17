class Cat < ApplicationRecord  
  validates :breed_name, presence: true
  validates :cat_url, presence: true
  belongs_to :breed, counter_cache: true

  scope :recent, -> { order(created_at: :desc) }
  scope :filter_by_breed, -> (breed_name) { where breed_name: breed_name }
end
