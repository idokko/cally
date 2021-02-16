class ListsController < ApplicationController
    def index
        @works = Work.all
    end
end
