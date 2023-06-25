
module JwtHelpers
  def add_to_whitelist(user_id, new_token)
    #retrieve the members and remove expired tokens if they exist
    tokens = REDIS.smembers(user_id)
    filtered_tokens = []
    unless tokens.empty?
      filtered_tokens = tokens.select do |token|
        expiry_date = token.split(":")[1]&.to_i
        DateTime.current.to_i >= expiry_date.to_i
      end
    end

    #add the new token and save
    filtered_tokens.push(new_token)
    REDIS.del(user_id)
    REDIS.sadd(user_id, filtered_tokens)
  end

  def is_in_whitelist?(user_id, user_token)
    tokens = REDIS.smembers(user_id);
    whitelisted = false
    tokens.each do |token| 
      token = token.split(":")[0];
      if token = user_token
        whitelisted = true
        break
      end
    end
    
    return whitelisted
  end

  def remove_from_whitelist(user_id, user_token) 
    tokens = REDIS.smembers(user_id)
    filtered_tokens = []
    filtered_tokens = tokens.reject do |token|
      token = token.split(":")[0]
      token == user_token
    end
    REDIS.del(user_id)
    REDIS.sadd(user_id, filtered_tokens)
  end

  def remove_all_whitelist(user_id)
    REDIS.del(user_id)
  end
end

