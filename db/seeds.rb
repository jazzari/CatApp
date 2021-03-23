# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'rest-client'

query = ['q=char', 'q=Egyptian', 'q=norw']
breed_url = "https://api.thecatapi.com/v1/breeds/search"
query.each do |query|
    br = breed_url+"?"+query
    data = JSON.parse( RestClient.get("#{br}#{ENV["CAT_API_KEY"]}") )[0]
    name = data['name']
    breeds = Breed.new do |b|
        b.name = name,
        b.breed_id = data['id'],
        b.rarity = data['rare']
    end
    breeds.name = name
    if breeds.save
        puts "saved breed"
      else
        puts "not saved breed"
      end
end