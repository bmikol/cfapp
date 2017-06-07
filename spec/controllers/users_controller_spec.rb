require 'rails_helper'

describe UsersController, type: :controller do
  before do
    @user = FactoryGirl.create(:user, email: 'user@foo.com')
    @admin = FactoryGirl.create(:user, admin: 'true', email: 'admin@foo.com')
  end
  describe 'GET #show' do
    context 'user is logged in' do
      before do
        sign_in @user
      end
      it 'loads correct user details' do
        get :show, params: { id: @user.id }
        expect(response).to be_success
        expect(response).to have_http_status(200)
        expect(assigns(:user)).to eq @user
      end
    end
    context 'no user is logged in' do
      it 'redirects to login' do
        get :show, params: { id: @user.id }
        expect(response).to redirect_to('/login')
      end
    end
    context 'one user cannot view another' do
      before do
        @user2 = FactoryGirl.create(:user, email: 'user2@foo.com')
        sign_in @user
      end
      it 'redirects when user unauthorized' do
        get :show, params: { id: @user2.id }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(home_path)
        expect(assigns(:user)).not_to eq @user
      end
    end
  end
  describe 'GET #index' do
    before do
      sign_in @user
      get :index
    end
    it 'renders index template with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'is valid with email and password' do
        expect{
          @user = FactoryGirl.create(:user, email: 'valid@foo.com')
        }.to change(User, :count).by(1)
      end
      it 'redirects user' do
        post :create, user: FactoryGirl.attributes_for(:user)
        expect(response).to render_template(:show)
      end
    end
    context 'without valid attributes' do
      it 'is not valid without email' do
        expect{
          post :create, params: { user: FactoryGirl.create(:user, email: '') }
        }.to raise_error
      end

      it 'is not valid without password' do
        expect{
          post :create, params: { user: FactoryGirl.create(:user, password: '') }
        }.to raise_error
      end
    end
  end

  context 'PUT #update' do
    before do
      sign_in @user
    end

    it 'can update' do
      put :update, id: @user, user: FactoryGirl.attributes_for(:user, email: 'foobar@foo.com')
      @user.reload
      expect(@user.email).to eq('foobar@foo.com')
    end

    it 'cannot update' do
      put :update, id: @user, user: FactoryGirl.attributes_for(:user, email: nil)
      expect(response).to render_template(:edit)
    end
  end

  context 'DELETE #destroy' do
    before do
      sign_in @admin
    end

    it 'allows admin to delete user' do
      expect(delete :destroy, params: { id: @user } ).to redirect_to(users_url)
    end
  end
end
