require 'rails_helper'

RSpec.describe Dashboard::TranslationsController, type: :controller do
  before do
    @user ||= create :user
    sign_in @user
    @app = create(:app, user: @user)
  end

  it { should use_before_action(:authenticate_user!) }

  describe '#index' do
    before { get :index }
    it { expect(assigns(:apps)).to be_decorated }
    it { expect(assigns(:apps).first).to eq(@app) }
    it { is_expected.to respond_with 200 }
    it { is_expected.to render_template :index }
  end

  describe '#show' do
    context 'when app is found' do
      before { get :show, id: @app }
      it { expect(assigns(:app)).to be_decorated }
      it { expect(assigns(:app)).to eq(@app) }
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template :show }
    end
    context 'when app is not found' do
      before { get :show, id: -1 }
      it { is_expected.to respond_with 404 }
      it { is_expected.to render_template 'shared/not_found' }
    end
  end

  describe '#new' do
    before { get :new }
    it { expect(assigns(:app)).to be_decorated }
    it { expect(assigns(:app)).to_not be_persisted }
    it { is_expected.to render_template :new }
    it { is_expected.to respond_with 200 }
  end

  describe '#create' do
    context 'when new app is valid' do
      before { post :create, app: attributes_for(:app) }
      it { expect(assigns(:app)).to be_valid }
      it { expect(assigns(:app)).to be_persisted }
      it { is_expected.to redirect_to(app_path assigns(:app)) }
      it { is_expected.to respond_with 302 }
      it { is_expected.to set_the_flash[:success] }
    end
    context 'when new app is invalid' do
      before { post :create, app: attributes_for(:app, name: nil) }
      it { expect(assigns(:app)).to be_decorated }
      it { expect(assigns(:app)).to_not be_valid }
      it { expect(assigns(:app)).to_not be_persisted }
      it { is_expected.to render_template :new }
      it { is_expected.to respond_with 200 }
      it { is_expected.to set_the_flash[:error].now }
    end
  end

  describe '#edit' do
    context 'when app is found' do
      before { get :edit, id: @app }
      it { expect(assigns(:app)).to be_decorated }
      it { expect(assigns(:app)).to eq(@app) }
      it { is_expected.to respond_with 200 }
      it { is_expected.to render_template :edit }
    end
    context 'when app is not found' do
      before { get :edit, id: -1 }
      it { is_expected.to respond_with 404 }
      it { is_expected.to render_template 'shared/not_found' }
    end
  end

  describe '#update' do
    context 'when app is found' do
      context 'when app update is valid' do
        before { put :update, id: @app, app: attributes_for(:app) }
        it { expect(assigns(:app)).to be_valid }
        it { expect(assigns(:app)).to be_persisted }
        it { is_expected.to redirect_to(app_path assigns(:app)) }
        it { is_expected.to respond_with 302 }
        it { is_expected.to set_the_flash[:success] }
      end
      context 'when app update is invalid' do
        before { put :update, id: @app, app: attributes_for(:app, name: nil) }
        it { expect(assigns(:app)).to_not be_valid }
        it { expect(assigns(:app)).to be_decorated }
        it { is_expected.to render_template :edit }
        it { is_expected.to respond_with 200 }
        it { is_expected.to set_the_flash[:error].now }
      end
    end
    context 'when app is not found' do
      before { put :update, id: -1 }
      it { is_expected.to respond_with 404 }
      it { is_expected.to render_template 'shared/not_found' }
    end
  end

  describe '#destroy' do
    context 'when app is found' do
      before { delete :destroy, id: @app }
      it { expect(assigns(:app)).to_not be_persisted }
      it { is_expected.to redirect_to(apps_path) }
      it { is_expected.to respond_with 302 }
      it { is_expected.to set_the_flash[:info] }
    end
    context 'when app is not found' do
      before { delete :destroy, id: -1 }
      it { is_expected.to respond_with 404 }
      it { is_expected.to render_template 'shared/not_found' }
    end
  end
end
