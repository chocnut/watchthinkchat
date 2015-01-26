WatchThinkChat::Application.routes.draw do
  ActiveAdmin.routes(self)

  constraints DomainConstraint.new(["app.#{ENV['base_url']}",
                                    "app.#{ENV['base_url']}.lvh.me"]) do
    devise_for :users, skip: [:session, :password, :registration, :confirmation], controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
    }
    authenticated :user do
      scope module: 'dashboard' do
        resources :campaigns, except: [] do
          resources :build, controller: 'campaigns/build', except: [] do
            collection do
              namespace :api, defaults: { format: :json } do
                resources :questions
              end
            end
          end
        end
      end
    end
    localized do
      devise_for :users, path: '', skip: [:omniauth_callbacks], controllers: {
        registrations: 'users/registrations' }
      authenticated :user do
        root to: 'dashboard#index', as: :authenticated_root
        scope module: 'dashboard' do
          resource :user
          resources :campaigns, only: [:index, :new, :show, :destroy] do
            resources :invites, module: 'campaigns', as: :user_translator_invites
            resources :permissions, only: [:destroy], module: 'campaigns'
            resources :build, controller: 'campaigns/build'
          end
          namespace :api, defaults: { format: :json } do
            get 'campaigns/:campaign_id/locales/:locale_id/translations/:id',
                to: 'translations#show'
            put 'campaigns/:campaign_id/locales/:locale_id/translations/:id',
                to: 'translations#update'
            delete 'campaigns/:campaign_id/locales/:locale_id/translations/:id',
                   to: 'translations#destroy'
          end
          resources :translations do
          end
        end
      end
      root to: redirect("#{I18n.locale}/#{I18n.t('routes.sign_in')}"), as: :unauthenticated_root
    end
    root to: redirect(I18n.locale.to_s), as: :no_locale_root
  end

  constraints DomainConstraint.new(["api.#{ENV['base_url']}",
                                    "api.#{ENV['base_url']}.lvh.me"]) do
    devise_for :visitors
    get 'token',
        to: 'api#token',
        as: :api_root,
        defaults: { format: 'js' }
    match '*path',
          to: 'api#cors_preflight_check',
          via: [:options]
    scope module: 'api' do
      api_version(
        module: 'V1',
        header: {
          name: 'Accept',
          value: "application/api.#{ENV['base_url']}; version=1" },
        parameter: { name: 'version', value: '1' },
        path: { value: 'v1' }) do
        resource :visitor, only: [:show, :update]
        resources :invitees, only: [:index, :create, :show, :update] do
          scope module: :invitees do
            resources :emails, only: [:create]
          end
        end
        resources :interactions, only: [:create, :update]
      end
    end
  end

  localized do
    root 'site#index'
  end

  root to: redirect("#{I18n.locale}/"), as: :no_locale_visitor_root
end
