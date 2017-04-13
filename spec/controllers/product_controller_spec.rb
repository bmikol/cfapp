require 'rails_helper'

describe ProductsController, type: :controller do
  before do
    @product = Product.create!(name: 'race bike', price: '99.99')
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
end
