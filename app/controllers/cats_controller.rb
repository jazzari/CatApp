class CatsController < ApplicationController
    include Paginable

    def index
        @cats = Cat.where(nil) 
        @cats = @cats.filter_by_breed(params[:breed_name]) if params[:breed_name].present?
        paginated = paginate(@cats.recent)
        render json: serializer.new(paginated.items), status: :ok
    end

    def show
        cat = Cat.find(params[:id])
        render json: serializer.new(cat)
        rescue ActiveRecord::RecordNotFound => e 
            render json: { message: e.message }
    end

    def destroy
        cat = Cat.find(params[:id])
        cat.destroy
        head :no_content
    end

    private
    def serializer
        CatSerializer
    end

end