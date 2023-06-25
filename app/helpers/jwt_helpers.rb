
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

  def get_token_link_hex(user_id, user_token)
    tokens = REDIS.smembers(user_id);
    token_hex = ''
    tokens.each do |token| 
      token, exp, hex = token.split(":");
      if token = user_token
        token_hex = hex
        break
      end
    end
    
    return token_hex
  end

  def remove_from_whitelist(user_id, user_token) 
    tokens = REDIS.smembers(user_id)
    filtered_tokens = []
    
    #find the linking hex for the token
    interest_token = tokens.find do |token|
      token.split(":")[0] == user_token
    end
    link_hex = interest_token.split(":")[2]

    #filter out the tokens with same link_hex as obtained
    filtered_tokens = tokens.reject do |token|
      hex = token.split(":")[2]
      hex == link_hex
    end

    #update the REDIS store by removing the entire key and adding
    #the key back with the updated array
    REDIS.del(user_id)
    REDIS.sadd(user_id, filtered_tokens)
  end

  def remove_all_whitelist(user_id)
    REDIS.del(user_id)
  end
end

