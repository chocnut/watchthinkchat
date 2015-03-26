class DashboardController < Dashboard::BaseController
  def index
    return unless orientated?
    authorize! :manage, Dashboard
    return redirect_to campaigns_path if current_user.manager?
    return redirect_to translations_path if current_user.translator?
  end

  protected

  def orientated?
    return true if current_user.orientated?
    if current_user.manager?
      render 'orientation_manager'
    elsif current_user.translator?
      render 'orientation_translator'
    end
    current_user.update(orientated: true)
    false
  end
end
