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
                rarity: breed.rarity,
                cats_count: breed.cats_count
            )
        end

        it "paginates results" do 
            breed1, breed2, breed3 = create_list(:breed, 3)
            get '/breeds', params: { page: { number: 2, size: 1 } }
            expect(json_data.length).to eq(1)
            expect(json_data.first[:id]).to eq(breed2.id.to_s)
        end

        it "should return filtered breeds by rarity" do 
            breed1, breed2, breed3 = create_list(:breed, 3, rarity: 4)
            breed1.update_column(:rarity, 2)
            get '/breeds', params: { rarity: 4 }
            expect(json_data.length).to eq(2)
            expect(json_data.first[:attributes][:rarity]).to eq(4)

            get '/breeds', params: { rarity: 2 }
            expect(json_data.length).to eq(1)
            expect(json_data.first[:attributes][:rarity]).to eq(2)
        end

        it "sould return filtered breeds by name" do 
            breed1, breed2, breed3 = create_list(:breed, 3, name: "funnycat")
            breed1.update_column(:name, 'happycat')
            get '/breeds', params: { name: "fun" }
            expect(json_data.length).to eq(2)
            expect(json_data.first[:attributes][:name]).to eq("funnycat")

            get '/breeds', params: { name: "happyc" }
            expect(json_data.length).to eq(1)
            expect(json_data.first[:attributes][:name]).to eq("happycat")
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
            expect(json_data[:id]).to eq(breed.id.to_s)
            expect(json_data[:type]).to eq('breeds')
            expect(json_data[:attributes]).to eq(
                name: breed.name,
                breed_id: breed.breed_id,
                rarity: breed.rarity,
                cats_count: breed.cats_count
            )
        end
    end

    describe "#destroy" do 
        let(:breed) { create :breed }
        subject { delete "/breeds/#{breed.id}" }

        it "should have 204 status code" do 
            subject
            expect(response).to have_http_status(:no_content)
        end

        it "should destroy the breed" do 
            breed
            expect{ subject }.to change{ Breed.count }.by(-1)
        end

    end

end