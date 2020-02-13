class ApplicationController < ActionController::Base
  include Pagy::Backend
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = t('pundit.not_authorized')
    redirect_to user_session_path
  end
end
