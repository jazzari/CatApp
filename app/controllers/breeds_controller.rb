class BreedsController < ApplicationController
    include Paginable
    def index 
        paginated = paginate(Breed.ordered)
        render json: serializer.new(paginated.items), status: :ok
    end

    def show
    end

    def destroy
    end

    private
    def serializer
        BreedSerializer
    end

end