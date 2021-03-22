require 'rails_helper'

RSpec.describe "Registration", :type => :request do 
    before(:each) do 
        @signup_params = {
            email: 'user@example.com',
            password: 'password',
            password_confirmation: 'password'
        }
    end

    describe "Email registration method" do 
        describe 'POST /auth/' do 
            context 'With valid signup params' do 
                subject { '/auth/' }
                before do 
                    post subject, params: @signup_params
                end

                it "should return success status" do 
                    expect(response).to have_http_status(:ok)
                end

                it "should return valid authentication header" do 
                    expect(response.headers['access-token']).to be_present
                end

                it "should return client in authentication header" do 
                    expect(response.headers['client']).to be_present
                end

                it "should return uid in authentication header" do 
                    expect(response.headers['uid']).to be_present
                end

                it "should return expiry in authentication header" do 
                    expect(response.headers['expiry']).to be_present
                end

                it "should create a new user" do 
                    expect{ post subject, params: @signup_params.merge({email: "test@example.com"}) 
                }.to change(User, :count).by(1)
                end
            end

            context 'With invalid signup params' do 
                subject { '/auth/' }
                before { post subject }

                it "should return status code 422" do
                    expect(response).to have_http_status(:unprocessable_entity)
                end
            end
        end
    end
end