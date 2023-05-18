class PagesController < ApplicationController
    before_action :authenticate_user!
  
    # Action: index
    # Description: Retrieves and paginates the pages owned by the current user
    def index
      @pages = current_user.pages.paginate(page: params[:page], per_page: 4)
    end
  
    # Action: new
    # Description: Initializes a new instance of the Page model
    def new
      @page = Page.new
    end
  
    # Action: create
    # Description: Creates a new page associated with the current user
    def create
      @page = current_user.pages.build(page_params)
  
      if @page.save
        begin
          scrape_page(@page)
          redirect_to pages_path, notice: 'Page was successfully created and scraped.'
        rescue OpenURI::HTTPError => e
          redirect_to pages_path, alert: "Failed to scrape page: #{e.message}"
        end
      else
        render :new
      end
    end
  
    # Action: show
    # Description: Retrieves and paginates the links belonging to the requested page
    def show
      @page = current_user.pages.find(params[:id])
      @links = @page.links.limit(4).offset(params[:page].to_i * 4).to_a
    
      @links_paginated = WillPaginate::Collection.create(params[:page].to_i + 1, 4, @page.links.count) do |pager|
        pager.replace(@links)
      end
    end
  
    private
  
    # Method: page_params
    # Description: Defines the permitted parameters for creating a page
    def page_params
      params.require(:page).permit(:name)
    end
  
    # Method: scrape_page
    # Description: Scrapes the provided page for links and creates Link records
    def scrape_page(page)
      require 'open-uri'
  
      open_options = { ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }
      doc = Nokogiri::HTML(URI.open(page.name, open_options))
  
      doc.css('a').each do |link_element|
        url = link_element['href']
        name = link_element.text.strip
  
        next unless url.present?
  
        page.links.create(url: url, name: name)
      end
    end
end
