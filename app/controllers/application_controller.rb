class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_up_path_for(resource)
    root_path
  end

  def after_inactive_sign_up_path_for(resource)
    root_path
  end

  # ログイン後はユーザー、コーチともにマイページへ遷移
  def after_sign_in_path_for(resourse)
    if current_user
      users_my_page_path
    elsif current_coach
      coaches_coach_path(current_coach.id)
    end
  end

  # ログアウト後は　topページへ
  def after_sign_out_path_for(resourse)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
  end
end
