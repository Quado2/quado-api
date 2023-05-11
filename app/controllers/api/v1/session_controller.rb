module Api
  module V1
    class SessionController < ApiController
      skip_before_action :authenticate

      def login 
        const 
      end


      def login_params
        params.permit(:email, :password)
      end
      
    end
  end
end