class BreedSerializer
  include JSONAPI::Serializer
  set_type :breeds
  attributes :name, :breed_id, :rarity
end
