module Api
  class UsersController < ApplicationController

    before_action :restrict_current_user, except: [:index, :update_me, :me]

    def index
      render json: UsersRepresenter.new(User.sooners(current_user['sso_id'])).basic
    end

    def show
      render json: OneUserRepresenter.new(User.find(params[:id])).basic
    end

    def update
      user = User.find(params[:id])
      if user.update(user_params)
        render json: OneUserRepresenter.new(user).basic
      else
        render json: { errors: user.errors.messages }, status: 422
      end
    end

    def update_me
      if current_user.update(user_params)
        render json: CurrentUserRepresenter.new(current_user).basic
      else
        render json: { errors: current_user.errors.messages }, status: 422
      end
    end

    def me
      render json: CurrentUserRepresenter.new(current_user).basic
    end

    private
      def restrict_current_user
        head :unauthorized if current_user.id.to_s == params[:id]
      end

      def user_params
        params.require(:user).permit(:birthday_day, :birthday_month, :szama, :about, :done)
      end
  end
end