module Api
  module V1
    class UsersController < ApiController

      before_action :user_sign_up_params, :verify_role, only: [:create]

      def create
        p(user_sign_up_params)
        @user = User.create!(user_sign_up_params)
        if @user.persisted?
          @user.roles << @role
          @user.update!

          return json_response(message: "User created", status: 201, object: @user)
        end

      end


      def user_sign_up_params
        params.permit(
          :password, 
          :password_confirmation, 
          :email, 
          :phone_number,
          :role,   
        )
      end

      def verify_role
        @role = Role.find_by(title: params[:role_title])
        return json_response(error: "Invalid role title provided", status: 400) unless @role
      end

    end
  end
end

