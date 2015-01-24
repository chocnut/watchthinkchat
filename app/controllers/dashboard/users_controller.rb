module Dashboard
  class UsersController < Dashboard::BaseController
    decorates_assigned :user

    def update
      load_user
      build_user
      save_user
      redirect_to "/#{@user.locale}"
    end

    protected

    def load_user
      @user ||= user_scope
    end

    def build_user
      @user.attributes = user_params
    end

    def user_scope
      current_user
    end

    def save_user
      @user.save
    end

    def user_params
      user_params = params[:user]
      return {} unless user_params
      user_params.permit(:locale)
    end
  end
end
