RSpec.describe LinksController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      page = Page.create(name: "Page 1")
      get :index, params: { page_id: page.id }
      expect(response).to render_template(:index)
    end

    it "assigns @page with the requested page" do
      page = Page.create(name: "Page 1")
      get :index, params: { page_id: page.id }
      expect(assigns(:page)).to eq(page)
    end

    it "assigns @links with the links of the requested page" do
      page = Page.create(name: "Page 1")
      link1 = page.links.create(name: "Link 1", url: "https://example.com")
      link2 = page.links.create(name: "Link 2", url: "https://example.com")

      get :index, params: { page_id: page.id }
      expect(assigns(:links)).to match_array([link1, link2])
    end
  end
end