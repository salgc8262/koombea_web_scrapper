RSpec.describe PagesController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end

    it "assigns @pages with current user's pages" do
      user = User.create(email: "test@example.com", password: "password")
      page1 = user.pages.create(name: "Page 1")
      page2 = user.pages.create(name: "Page 2")

      sign_in user

      get :index
      expect(assigns(:pages)).to match_array([page1, page2])
    end
  end

  describe "GET #new" do
    it "renders the new template" do
      sign_in User.create(email: "test@example.com", password: "password")

      get :new
      expect(response).to render_template(:new)
    end

    it "assigns a new page to @page" do
      sign_in User.create(email: "test@example.com", password: "password")

      get :new
      expect(assigns(:page)).to be_a_new(Page)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new page" do
        user = User.create(email: "test@example.com", password: "password")
        sign_in user

        expect {
          post :create, params: { page: { name: "New Page" } }
        }.to change(Page, :count).by(1)
      end

      it "redirects to the pages index" do
        user = User.create(email: "test@example.com", password: "password")
        sign_in user

        post :create, params: { page: { name: "New Page" } }
        expect(response).to redirect_to(pages_path)
      end
    end

    context "with invalid parameters" do
      it "does not create a new page" do
        user = User.create(email: "test@example.com", password: "password")
        sign_in user

        expect {
          post :create, params: { page: { name: "" } }
        }.not_to change(Page, :count)
      end

      it "renders the new template" do
        user = User.create(email: "test@example.com", password: "password")
        sign_in user

        post :create, params: { page: { name: "" } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #show" do
    it "renders the show template" do
      user = User.create(email: "test@example.com", password: "password")
      page = user.pages.create(name: "Page 1")
      sign_in user

      get :show, params: { id: page.id }
      expect(response).to render_template(:show)
    end

    it "assigns the requested page to @page" do
      user = User.create(email: "test@example.com", password: "password")
      page = user.pages.create(name: "Page 1")
      sign_in user

      get :show, params: { id: page.id }
      expect(assigns(:page)).to eq(page)
    end
  end
end
