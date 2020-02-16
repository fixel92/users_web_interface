module Api
  module V1
    class UsersController < Api::V1::BaseController
      skip_before_action :verify_authenticity_token
      before_action :authenticate_user!
      before_action :set_user

      def show
        authorize @user

        render json: UserSerializer.new(@user)
      end

      def update
        authorize @user

        if @user.update(user_params)
          render json: UserSerializer.new(@user)
        else
          render json: { status: 'Error' }
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
