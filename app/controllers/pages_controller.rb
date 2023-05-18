class PagesController < ApplicationController
    before_action :authenticate_user!
  
    def index
      @pages = current_user.pages.paginate(page: params[:page], per_page: 4)
    end
  
    def new
      @page = Page.new
    end
  
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
  
    def show
      @page = current_user.pages.find(params[:id])
      @links = @page.links.limit(4).offset(params[:page].to_i * 4).to_a
    
      @links_paginated = WillPaginate::Collection.create(params[:page].to_i + 1, 4, @page.links.count) do |pager|
        pager.replace(@links)
      end
    end
  
    private
  
    def page_params
      params.require(:page).permit(:name)
    end
  
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
