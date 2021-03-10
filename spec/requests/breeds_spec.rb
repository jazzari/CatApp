require 'rails_helper'

RSpec.describe BreedsController do 
    describe "#index" do
        subject { get '/breeds' }
        it "should return a success response" do
            subject
            expect(response).to have_http_status(:ok)
        end 

        it "should return proper JSON" do
            breed = create(:breed)
            subject
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

    describe "#show" do 
        let(:breed) { create :breed }
        subject { get "/breeds/#{breed.id}" }

        it "should return a success response" do 
            subject
            expect(response).to have_http_status(:ok)
        end

        it "should return proper JSON" do 
            subject
            # expected_breed = Breed.find(breed.id)
            expect(json_data[:id]).to eq(breed.id.to_s)
            expect(json_data[:type]).to eq('breeds')
            expect(json_data[:attributes]).to eq(
                name: breed.name,
                breed_id: breed.breed_id,
                rarity: breed.rarity
            )
        end
    end
end