require 'rails_helper'

RSpec.describe "Session", :type => :request do 
    before(:each) do 
        @user = create :user 
        @signin_url = '/auth/sign_in'
        @signout_url = '/auth/sign_out'
        @login_params = {
            email: @user.email,
            password: @user.password
        }
    end

    describe 'POST /auth/sign_in' do 
        context 'With valid login params' do 
            before do 
                post @signin_url, params: @login_params, as: :json
            end

            it "should return success status code" do 
                expect(response).to have_http_status(:ok)
            end

            it "should return access-token in authentication header" do 
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
        end

        context 'With invalid login params' do
            before { post @signin_url }

            it "should return status code 401" do 
                expect(response).to have_http_status(:unauthorized)
            end
        end
    end

    describe 'DELETE /auth/sign_out' do 
        before do 
            post @signin_url, params: @login_params, as: :json
            @headers = {
                'uid' => response.headers['uid'],
                'client' => response.headers['client'],
                'access-token' => response.headers['access-token']
            }
        end

        it "should return success status code" do 
            delete @signout_url, headers: @headers
            expect(response).to have_http_status(:ok)
        end
    end
end