module Api
  module V1
    class SessionController < ApiController


      def login 
        email = params[:email]
        password = params[:password]

        unless email && password
          return json_response(message: "Password / Email must be provided", status: :unprocessable_entity)
        end
        
        @user = User.find_by(email: email)
        return render_unauthorized unless @user
   
        if(@user.authenticate(password))

          access_payload = {
            user_Id: @user.id, 
            exp: Time.now.to_i + JWT_ACCESS_TOKEN_EXPIRY
          }
          refresh_payload = {
            user_Id: @user.id, 
            exp: Time.now.to_i + JWT_REFRESH_TOKEN_EXPIRY
          }

          #using the user id as key save the tokens and it's expiry as a list
          #in redis, but remove all expired tokens before saving to the the list

          #to save to redis, include the expiry as part of the last item;
          


          accessToken = JWT.encode(access_payload,JWT_SECRET)
          refreshToken = JWT.encode({user_id:@user.email}, JWT_SECRET)
          serialized_user = UserSerializer.new(@user).serializable_hash[:data][:attributes]

          return json_response(
            message: "Login Successful",
            object: {accessToken: accessToken, refreshToken: refreshToken, user: serialized_user}
            )
        end
        return render_unauthorized
      end
      
    end
  end
end