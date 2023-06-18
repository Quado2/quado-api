require 'securerandom'

module Api
  module V1
    class UsersController < ApiController

      before_action :user_sign_up_params, :verify_role, only: [:create]

      def create

        p "At the controller"
        @user = User.create!(user_sign_up_params)
        
        if @user.persisted?
          @user.roles << @role
          code = SecureRandom.hex;
          @user.verification_token = code
          @user.verification_token_sent_at = DateTime.now
          @user.save!
          url = "http://localhost:4000/api/v1/verify-token?token=#{code}"
          UserAccountMailer.with(user: @user, url: url,role: 'viewer').account_confirmation.deliver_now
          return json_response(message: "User created! Check your email for confimation", status: 201)
        end
      end


      def verify_token
        token = params[:token]
        return json_response(error: "No token provided !", status: 400) if(token.size < 1)
        user = User.find_by(verification_token: token)        
        return json_response(error: "Invalid token provided !", status: 404) unless user
        user.email_verified = true;
        json_response(message: "User verified succesfully!}", status: 200) if user.save!
      end


      def add_role
        user = User.find(params[:user_id])
        role = Role.find(params[:role_id])
        user_role = UserRole.create!(user_id: params[:user_id], role_id: params[:role_id])
        user = User.includes(:roles).find(params[:user_id])
        return json_response(message: "User linked to role", status: 201, object: serialize(user))
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

