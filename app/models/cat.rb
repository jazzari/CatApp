class Cat < ApplicationRecord  
  validates :breed_name, presence: true
  validates :cat_url, presence: true
  belongs_to :breed, counter_cache: true

  scope :recent, -> { order(created_at: :desc) }
end
