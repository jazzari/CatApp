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
            body = JSON.parse(response.body).deep_symbolize_keys
            pp body
            expect(body).to eq(
                data: [
                    {
                        id: breed.id.to_s,
                        type: 'breeds',
                        attributes: {
                            name: breed.name,
                            breed_id: breed.breed_id,
                            rarity: breed.rarity
                        }
                    }
                ]
            )
        end
    end
end