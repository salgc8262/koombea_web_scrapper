class LinksController < ApplicationController
    def index
      @page = Page.find(params[:page_id])
      @links = @page.links.page(params[:page]).per(4)
    end
end
