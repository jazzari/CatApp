class CatSerializer
  include JSONAPI::Serializer
  set_type :cats
  attributes :breed_name, :cat_url
end
