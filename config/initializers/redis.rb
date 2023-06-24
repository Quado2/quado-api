redis_host = ENV['REDIS_HOST']
redis_port = ENV['REDIS_PORT']

# The constant below will represent ONE connection, present globally in models, controllers, views etc for the instance. No need to do Redis.new everytime
REDIS = Redis.new(host: redis_host, port: redis_port.to_i)