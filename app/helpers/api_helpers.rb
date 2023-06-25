module ApiHelpers

include Constants;

  def authenticate
    authorization = request.headers["Authorization"]
    access_token = authorization&.split(" ")[1] if(authorization)
    p "Obtained token", access_token
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
end