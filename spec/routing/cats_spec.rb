require 'rails_helper'

RSpec.describe '/cats routes' do 

    it "routes to cats#index" do 
        expect(get '/cats').to route_to('cats#index')
    end

    it "routes to cats#show" do 
        expect(get '/cats/1').to route_to('cats#show', id: '1')
    end

    it "routes to cats#destroy" do 
        expect(delete '/cats/1').to route_to('cats#destroy', id: '1')
    end

end