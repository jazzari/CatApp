require 'rails_helper'

RSpec.describe '/breeds routes' do 
    it "routes to breeds#index" do 
        expect(get '/breeds').to route_to('breeds#index')
    end
end