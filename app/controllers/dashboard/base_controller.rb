module Dashboard
  class BaseController < ApplicationController
    layout 'dashboard'
    before_action :authenticate_by_facebook!
    before_action :change_to_set_locale!

    protected

    def change_to_set_locale!
      return unless I18n.locale && current_user.locale
      return unless I18n.locale != current_user.locale.to_sym
      redirect_to "/#{current_user.locale}"
    end

    def current_manager
      current_user.as :manager
    end

    def current_translator
      current_user.as :translator
    end
  end
end
