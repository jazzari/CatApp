class BreedsController < ApplicationController
    include Paginable
    def index 
        @breeds = Breed.where(nil) 
        @breeds = @breeds.filter_by_rarity(params[:rarity]) if params[:rarity].present?
        paginated = paginate(@breeds.ordered)
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