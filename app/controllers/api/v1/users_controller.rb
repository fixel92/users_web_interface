module Api
  module V1
    class UsersController < Api::V1::BaseController
      skip_before_action :verify_authenticity_token

      def show
        @user = User.find(params[:id])

        render json: UserSerializer.new(@user)
      end
    end
  end
end
