class BreedsController < ApplicationController
    include Paginable
    before_action :authenticate_user!, only: :destroy
    
    def index 
        @breeds = Breed.where(nil) 
        @breeds = @breeds.filter_by_rarity(params[:rarity]) if params[:rarity].present?
        @breeds = @breeds.filter_by_name(params[:name]) if params[:name].present?
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
        if current_user.admin
            breed.destroy
        else
            render json:("You need to be an Admin to delete a breed"), status: :method_not_allowed
        end
        head :no_content
    end

    private
    def serializer
        BreedSerializer
    end

end