require 'rails_helper'

RSpec.describe '/breeds routes' do 
    it "routes to breeds#index" do 
        expect(get '/breeds').to route_to('breeds#index')
    end

    it "routes to breeds#show" do 
        expect(get '/breeds/1').to route_to('breeds#show', id: '1')
    end

    it "routes to breeds#destroy" do 
        expect(delete 'breeds/1').to route_to('breeds#destroy', id: '1')
    end
end