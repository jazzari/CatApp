FactoryBot.define do
  factory :breed do
    sequence (:name) { |n| "CatBreed#{n}" }
    breed_id { "catb" }
    rarity { 1 }
    cats_count { 0 }
  end
end
