require 'rails_helper'

RSpec.describe BreedsController do 
    describe "#index" do
        it "should return a success response" do
            get '/breeds'
            expect(response).to have_http_status(:ok)
        end 

        it "should return a proper JSON" do
            breed = create(:breed)
            get '/breeds'
            expect(json_data.length).to eq(1)
            first = json_data.first
            expect(first[:id]).to eq(breed.id.to_s)
            expect(first[:type]).to eq('breeds')
            expect(first[:attributes]).to eq(
                name: breed.name,
                breed_id: breed.breed_id,
                rarity: breed.rarity
            )
        end

        it "paginates results" do 
            breed1, breed2, breed3 = create_list(:breed, 3)
            get '/breeds', params: { page: { number: 2, size: 1 } }
            expect(json_data.length).to eq(1)
            expect(json_data.first[:id]).to eq(breed2.id.to_s)
        end
    end
end