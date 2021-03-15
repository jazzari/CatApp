class CatsController < ApplicationController
    include Paginable

    def index
        cats = Cat.all
    end

    def show
        cat = Cat.find(params[:id])
    end

    def destroy
        cat = Cat.find(params[:id])
        cat.destroy
    end

end