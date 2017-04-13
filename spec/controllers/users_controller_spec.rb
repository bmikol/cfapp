require 'rails_helper'

describe UsersController, type: :controller do
  before do
    @user = User.create!(email: 'foo@bar.com', password: 'password')
  end
  describe 'GET #show' do
    context 'user is logged in' do
      before do
        sign_in @user
      end
      it 'loads correct user details' do
        get :show, id: @user.id
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(assigns(:user)).to eq @user
      end
    end
    context 'no user is logged in' do
      it 'redirects to login' do
        get :show, id: @user.id
        expect(response).to redirect_to('/login')
      end
    end
    context 'one user cannot view another' do
      before do
        @user2 = User.create!(email: 'bar@bar.com', password: 'foobar')
        sign_in @user
      end
      it 'redirects when user unauthorized' do
        get :show, id: @user2.id
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(home_path)
        expect(assigns(:user)).not_to eq @user
      end
    end
  end
end
