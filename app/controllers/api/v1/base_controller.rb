class Api::V1::BaseController < ApplicationController
  include Pundit

  private

  # https://github.com/wayne5540/pundit/commit/81b9bca985d6739fb7b880d63f8550d39c2fe730
  def policy(record)
    policy = "#{controller_path.classify}Policy"
    policies[record] ||= policy.constantize.new(current_user, record)
  end

  def user_not_authorized
    render json: { 'error': 'Forbidden', 'status': 403 }
  end
end
