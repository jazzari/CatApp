require 'rails_helper'

RSpec.describe CatsController do 
    describe "#index" do 
        subject { get '/cats' }
        let(:breed) { create :breed }

        it "should return success response" do 
            subject
            expect(response).to have_http_status(:ok)
        end

        it "should return proper json" do 
            cat = create(:cat, breed_id: breed.id)
            subject
            expect(json_data.length).to eq(1)
            first = json_data.first
            expect(first[:id]).to eq(cat.id.to_s)
            expect(first[:type]).to eq('cats')
            expect(first[:attributes]).to eq(
                breed_name: cat.breed_name,
                cat_url: cat.cat_url
            )
        end

        it "paginates results" do 
            cat1, cat2, cat3 = create_list(:cat, 3, breed_id: breed.id)
            get '/cats', params: { page: { number: 2, size: 1 } }
            expect(json_data.length).to eq(1)
            expect(json_data.first[:id]).to eq(cat2.id.to_s)
        end
    end

    describe "#show" do 
    end

    describe "#destroy" do 
    end
end