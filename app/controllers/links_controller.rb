class LinksController < ApplicationController
    # Action: index
    # Description: Retrieves links associated with a specific page and paginates the results
    def index
      # Find the page based on the provided page_id parameter
      @page = Page.find(params[:page_id])
      # Retrieve links belonging to the page, paginate the results
      @links = @page.links.page(params[:page]).per(4)
    end
end
