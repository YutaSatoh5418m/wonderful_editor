class Api::V1::UsersController < Api::V1::BaseApiController
  skip_before_action :authenticate_user_from_token!, only: [:create]

  def index
    users = User.all
    render json: users, each_serializer: Api::V1::UserSerializer
  end

  def show
    user = User.find(params[:id])
    render json: user, serializer: Api::V1::UserSerializer
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      render json: user, serializer: Api::V1::UserSerializer
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    render json: { message: "User deleted successfully" }, status: :ok
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password)
    end
end
