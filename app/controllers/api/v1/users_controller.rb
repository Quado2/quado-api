module Api
  module V1
    class UsersController < ApiController

      before_action :user_sign_up_params, :verify_role, only: [:create]

      def create
        p(user_sign_up_params)
        @user = User.create!(user_sign_up_params)
        
        if @user.persisted?
          @user.roles << @role
          @user.save!
          return json_response(message: "User created", status: 201, object: @user)
        end
      end

      def add_role
        user = User.find(params[:user_id])
        role = Role.find(params[:role_id])
        user_role = UserRole.create!(user_id: params[:user_id], role_id: params[:role_id])

        p user_role
        user = User.includes(:roles).find(params[:user_id])
        return json_response(message: "User linked to role", status: 201, object: user)
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

