require 'rails_helper'

describe ProductsController, type: :controller do
  before do
    @product = FactoryGirl.create(:product)
  end

  describe 'GET #show' do
    before do
      get :show, id: @product.id
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
  end

  context 'POST #create' do
    it 'is not valid without name' do
      @product = FactoryGirl.build(:product, name: '', price: '99.99')
      expect(@product).not_to be_valid
    end

    it 'is not valid without price' do
      @product = FactoryGirl.build(:product, name: 'Awesome Bike', price: '')
      expect(@product).not_to be_valid
    end
  end

  context 'PUT #update' do
    before do
      @product = FactoryGirl.create(:product)
      @admin = FactoryGirl.build(:admin)
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
      @product = FactoryGirl.create(:product)
      @admin = FactoryGirl.build(:admin)
      sign_in @admin
    end

    it 'allows admin to delete product' do
      expect(delete :destroy, params: { id: @product } ).to redirect_to(products_url)
    end
  end
end
