module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token

      def show
        @user = User.find(params[:id])

        render json: UserSerializer.new(@user)
      end

      def create
        @user = User.new(user_params)

        if @user.save
          render json: UserSerializer.new(@user)
        else
          render json: UserSerializer.new(@user.errors), status: :unprocessable_entity
        end
      end

      def update
        @user = User.find(params[:id])

        if @user.update(user_params)
          render json: UserSerializer.new(@user)
        else
          render json: UserSerializer.new(@user.errors), status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:id, :name, :email, :avatar, :password)
      end
    end
  end
end
