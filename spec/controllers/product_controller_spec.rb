require 'rails_helper'

describe ProductsController, type: :controller do
  before do
    @product = FactoryGirl.create(:product)
    @admin = FactoryGirl.create(:user, admin: 'true', email: 'admin@foo.com')
  end

  describe 'GET #show' do
    before do
      # get :show, id: @product.id
      get :show, params: { id: 1 }
    end
    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #index' do
    before do
      get :index
    end
    it 'renders index template with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end
    context 'search' do
      before do
        @product2 = FactoryGirl.create(:product)
        @product3 = FactoryGirl.create(:product)
        @product4 = FactoryGirl.create(:product)
      end
      # it ''
    end
  end

  describe 'POST #create' do
    it 'is not valid without name' do
      @product = FactoryGirl.create(:product, name: '', price: '99.99')
      expect(@product).not_to be_valid
      expect(response).to render_template(:new)
    end

    it 'is not valid without price' do
      @product = FactoryGirl.build(:product, name: 'Awesome Bike', price: '')
      expect(@product).not_to be_valid
    end

    it 'is valid with name and price' do
      post :create, product: FactoryGirl.attributes_for(:product)
      expect(@product).to be_valid
      expect(response).to redirect_to(landing_page_path)
    end
  end

  context 'PUT #update' do
    before do
      sign_in @admin
    end

    it 'can update as admin' do
      @attr = { name: @product.name, image_url: @product.image_url, id: @product.id, price: 99.00 }
      put :update, params: { id: @product.id, product: @attr }
      @product.reload
      expect(@product.price).to eq 99.00
    end
  end

  context 'DELETE #destroy' do
    before do
      sign_in @admin
    end

    it 'allows admin to delete product' do
      expect(delete :destroy, params: { id: @product } ).to redirect_to(products_url)
    end
  end
end
