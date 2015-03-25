class DashboardController < Dashboard::BaseController
  def index
    authorize! :manage, Dashboard
    return redirect_to campaigns_path if current_user.manager?
    return redirect_to translations_path if current_user.translator?
  end
end
