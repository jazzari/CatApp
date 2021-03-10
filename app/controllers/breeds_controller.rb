class BreedsController < ApplicationController
    include Paginable
    def index 
        paginated = paginate(Breed.ordered)
        render json: serializer.new(paginated.items), status: :ok
    end

    def show
        breed = Breed.find(params[:id])
        render json: serializer.new(breed)
    rescue ActiveRecord::RecordNotFound => e 
        render json: { message: e.message }
    end

    def destroy
        breed = Breed.find(params[:id])
        breed.destroy
        head :no_content
    end

    private
    def serializer
        BreedSerializer
    end

end