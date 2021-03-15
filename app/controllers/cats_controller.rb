class CatsController < ApplicationController
    include Paginable

    def index
        paginated = paginate(Cat.recent)
        render json: serializer.new(paginated.items), status: :ok
    end

    def show
        cat = Cat.find(params[:id])
    end

    def destroy
        cat = Cat.find(params[:id])
        cat.destroy
    end

    private
    def serializer
        CatSerializer
    end

end