class BreedsController < ApplicationController
    def index 
        breeds = Breed.ordered
        render json: serializer.new(breeds), status: :ok
    end

    def show
    end

    def destroy
    end

    def serializer
        BreedSerializer
    end
end