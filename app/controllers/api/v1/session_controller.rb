module Api
  module V1
    class SessionController < ApiController

      skip_before_action :authenticate, except: [:refresh_access_token]
      skip_before_action :is_authorized?

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

          #used to link the access and refresh tokens in the whitelist db
          link_hex = SecureRandom.hex(10)

          #to save token to whitelist, include the expiry as part of the last item;
          add_to_whitelist(@user.id, "#{access_token}:#{access_exp.to_s}:#{link_hex}")
          add_to_whitelist(@user.id, "#{access_token}:#{refresh_exp.to_s}:#{link_hex}")

          return json_response(
            message: "Login Successful",
            object: {access_token: access_token, refresh_token: refresh_token, user: serialized_user}
            )
        end
        return render_bad_credentials
      end


      def logout
        token = request.headers["Authorization"]
        return render_logged_out unless token
        access_token  = token.split(" ")[1];

        begin
         user_id = JWT.decode(access_token, JWT_SECRET)[0]["user_id"]
         remove_from_whitelist(user_id, access_token);
         return render_logged_out
        rescue => e
          p e
          return render_logged_out
        end
      end


      def refresh_access_token
        token = request.headers["Authorization"]
        return render_unauthorized unless token;
        refresh_token = token.split(" ")[1]
        p "Current user: ", @current_user
        link_hex = get_token_link_hex(@current_user.id, refresh_token)

        access_exp = (Time.current + JWT_ACCESS_TOKEN_EXPIRY).to_i
        access_payload = {
          user_id: @current_user.id, 
          exp: access_exp
        }
        access_token = JWT.encode(access_payload,JWT_SECRET)

        add_to_whitelist(@current_user.id, "#{access_token}:#{access_exp.to_s}:#{link_hex}")
        return json_response(
            message: "Access token refreshed successful",
            object: {access_token: access_token}
            )
      end




      
    end
  end
end