module Api
  module V1
    class VerificationController < ApiController

      def verify_token
        token = params[:token]
        return json_response(error: "No token provided !", status: 400) if(token.size < 1)
        user = User.find_by(verification_token: token)        
        return json_response(error: "Invalid token provided !", status: 404) unless user
        user.email_verified = true;
        json_response(message: "User verified succesfully!}", status: 200) if user.save!
      end
    end
  end
end