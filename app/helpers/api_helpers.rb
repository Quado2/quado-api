module ApiHelpers

include Constants;

  def authenticate
    authorization = request.headers["Authorization"]
    access_token = authorization&.split(" ")[1] if(authorization)
    return render_unauthorized unless access_token

    begin
      user_id = JWT.decode(access_token, JWT_SECRET)[0]["user_id"]
      render_unauthorized unless is_in_whitelist?(user_id, access_token)
      @current_user = User.find(user_id)
    rescue StandardError => e
      p e
      render_unauthorized
    end
  end

  def throttle_token
    return unless Rails.env.production?

    if @token.present?
      key = "count:#{@token}"
      count = REDIS.get(key)

      unless count
        REDIS.set(key, 0)
        REDIS.expire(key, THROTTLE_TIME_WINDOW)
        return true
      end

      if count.to_i >= THROTTLE_MAX_REQUESTS
        json_response(message: 'You have fired too many requests. Please wait for some time.', status: 429) 
        return
      end
      REDIS.incr(key)
      true
    else
      false
    end
  end

 

  def is_authorized?
    method = request.method
    mod = request.path.split("/")[3]
    privileges = @current_user.roles[0]&.privileges

    return json_response(message: "You have no assigned role", status: 403) unless privileges

    if(@current_user.roles[0].title == 'super-admin')
      return
    end

    #find the particular privilege related to the mod
    interest_privilege = privileges.find {|privilege| privilege.mod&.name&.downcase === mod.downcase }
    return json_response(message: "You don't have the privilege to access this module", status: :forbidden) unless interest_privilege
    
    #check for authorization
    interest_access = METHOD_PRIVILEGE_MAP[method.downcase]
    user_authorized = interest_privilege[interest_access]
    return json_response(message: "You are not authorized for this action", status: 403) unless user_authorized
    
  end

 
end