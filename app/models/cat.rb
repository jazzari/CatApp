class Cat < ApplicationRecord  
  belongs_to :breed

  validates :breed_name, presence: true
  validates :cat_url, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
