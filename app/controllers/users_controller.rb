class UsersController < ApplicationController
  before_action :set_user, except: %i[index new create]
  before_action -> { authorize @user }, except: %i[index new create]

  def index
    @pagy, @users = pagy(User.all)
    authorize User
  end

  def new
    @user = User.new

    authorize @user
  end

  def show; end

  def edit; end

  def create
    @user = User.new(user_params)
    authorize @user

    if @user.save
      redirect_to root_path, notice: I18n.t('controllers.users.created')
    else
      render :new
    end
  end

  def update
    authorize @user

    if @user.update(user_params)
      redirect_to root_path, notice: I18n.t('controllers.users.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @user

    @user.destroy

    redirect_to root_path, notice: I18n.t('controllers.users.destroyed')
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :avatar, :password)
  end
end
