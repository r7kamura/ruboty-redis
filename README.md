# Ruboty::Redis
Store [Ruboty](https://github.com/r7kamura/ruboty/)'s memory in Redis.

## Usage
```ruby
# Gemfile
gem "ruboty-redis"
```

## ENV
```
REDIS_SAVE_INTERVAL - Interval sec to push data to Redis (default: 5)
REDIS_URL           - Redis URL (e.g. redis://foo:bar@example.com:6379/)
REDISTOGO_URL       - Another Redis URL (At least one Redis URL is required)
REDIS_NAMESPACE     - Redis name space (default: ruboty)
```

## Screenshot
![](https://raw.githubusercontent.com/r7kamura/ruboty-redis/master/images/screenshot.png)
