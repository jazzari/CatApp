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


query2 = ["breed_id=char", "breed_id=emau", "breed_id=norw"]
cat_url = "https://api.thecatapi.com/v1/images/search"
query2.each_with_index do |query, index|
    ca = cat_url+"?"+query+"&"+"limit=20"
    data = JSON.parse( RestClient.get("#{ca}#{ENV["CAT_API_KEY"]}") )
    data.each do |sub_array|
            name = sub_array['breeds'][0]['id']
            cats = Cat.new do |c|
                c.breed_name = sub_array['breeds'][0]['id'],
                c.cat_url = sub_array['url']
                c.breed_id = index + 1
            end
            cats.breed_name = name 
            if cats.save
                cats.update_column(:created_at, (rand*10).days.ago)
                puts cats.created_at
                puts "saved cat"
            else
                puts "not saved cat"
            end 
    end
end
