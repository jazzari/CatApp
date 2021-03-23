class CatsController < ApplicationController
    include Paginable
    before_action :authenticate_user!, only: :destroy

    def index
        @cats = Cat.where(nil) 
        @cats = @cats.filter_by_breed(params[:breed_name]) if params[:breed_name].present?
        if @cats.empty?
            render json:("there is no cats belonging to that breed")
        else
            paginated = paginate(@cats.recent)
            render json: serializer.new(paginated.items), status: :ok
        end
    end

    def show
        cat = Cat.find(params[:id])
        render json: serializer.new(cat)
        rescue ActiveRecord::RecordNotFound => e 
            render json: { message: e.message }
    end

    def destroy
        cat = Cat.find(params[:id])
        if current_user.admin
            cat.destroy
            head :no_content
        else
            render json:("You need to be an Admin to delete a cat"), status: :method_not_allowed
        end
        
    end

    private
    def serializer
        CatSerializer
    end

end