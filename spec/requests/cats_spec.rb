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

        it "should filter cats by breed" do 
            breed.breed_id = "funy"
            cat1, cat2 = create_list(:cat, 2, breed_id: breed.id)
            get '/cats', params: { breed_name: breed.breed_id}
            expect(json_data.length).to eq(2)
            first = json_data.first
            expect(first[:attributes][:breed_name]).to eq(breed.breed_id)

            breed2 = create(:breed, breed_id: "hapy")
            cat1.update_column(:breed_name, breed2.breed_id)
            get '/cats', params: { breed_name: breed2.breed_id}
            expect(json_data.length).to eq(1)
            first = json_data.first
            expect(first[:attributes][:breed_name]).to eq(breed2.breed_id)
        end
    end

    describe "#show" do 
        let(:breed) { create :breed }
        let(:cat) { create :cat, breed_id: breed.id}
        subject { get "/cats/#{cat.id}" }

        it "should return a success response" do 
            subject
            expect(response).to have_http_status(:ok)
        end

        it "should return a proper json response" do 
            subject
            expect(json_data[:id]).to eq(cat.id.to_s)
            expect(json_data[:type]).to eq('cats')
            expect(json_data[:attributes]).to eq(
                breed_name: cat.breed_name,
                cat_url: cat.cat_url
            )
        end
    end

    describe "#destroy" do 
        before(:each) do 
            @user = create :user, admin: true
            @signin_url = '/auth/sign_in'
            @login_params = {
                email: @user.email,
                password: @user.password
            }
            post @signin_url, params: @login_params, as: :json
            @header = response.headers.slice('client', 'access-token', 'uid', 'expiry')
        end
        let(:breed) { create :breed }
        let(:cat) { create :cat, breed_id: breed.id}
        subject { delete "/cats/#{cat.id}", headers: @header }

        it "should have 204 status code" do 
            subject
            expect(response).to have_http_status(:no_content)
        end

        it "should destroy the cat" do 
            cat
            expect{ subject }.to change{ Cat.count }.by(-1)
        end
    end
end