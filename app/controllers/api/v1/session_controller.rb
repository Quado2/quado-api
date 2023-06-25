module Api
  module V1
    class SessionController < ApiController

      skip_before_action :authenticate

      def login 
        email = params[:email]
        password = params[:password]

        unless email && password
          return json_response(message: "Password / Email must be provided", status: :unprocessable_entity)
        end
        
        @user = User.find_by(email: email)
        return render_bad_credentials unless @user
   
        if(@user.authenticate(password))
          access_exp = (Time.current + JWT_ACCESS_TOKEN_EXPIRY).to_i
          refresh_exp = (Time.current + JWT_REFRESH_TOKEN_EXPIRY).to_i

          access_payload = {
            user_id: @user.id, 
            exp: access_exp
          }
          refresh_payload = {
            user_id: @user.id, 
            exp: refresh_exp
          }

          access_token = JWT.encode(access_payload,JWT_SECRET)
          refresh_token = JWT.encode(refresh_payload, JWT_SECRET)
          serialized_user = UserSerializer.new(@user).serializable_hash[:data][:attributes]

          #to save token to whitelist, include the expiry as part of the last item;
          add_to_whitelist(@user.id, access_token+":"+access_exp.to_s )
          add_to_whitelist(@user.id, refresh_token+":"+refresh_exp.to_s )

          return json_response(
            message: "Login Successful",
            object: {access_token: access_token, refresh_token: refresh_token, user: serialized_user}
            )
        end
        return render_bad_credentials
      end


      def logout
        token = request.headers["token"]


      end
      
    end
  end
end