require "redis"
require "redis/namespace"

module Ruboty
  module Brains
    class Redis < Base
      NAMESPACE = "ruboty"

      KEY = "brain"

      attr_reader :thread

      env :REDIS_URL, "Redis URL (e.g. redis://foo:bar@example.com:6379/)"
      env :REDIS_SAVE_INTERVAL, "Interval sec to push data to Redis (default: 5)", optional: true

      def initialize
        super
        @thread = Thread.new { sync }
        @thread.abort_on_exception = true
      end

      def data
        @data ||= pull || {}
      end

      private

      def push
        client.set(KEY, Marshal.dump(data))
      end

      def pull
        if str = client.get(KEY)
          Marshal.load(str)
        end
      rescue TypeError
      end

      def sync
        loop do
          wait
          push
        end
      end

      def wait
        sleep(interval)
      end

      def client
        @client ||= ::Redis::Namespace.new(NAMESPACE, redis: redis)
      end

      def redis
        ::Redis.new(url: url)
      end

      def url
        ENV["REDIS_URL"]
      end

      def interval
        (ENV["REDIS_SAVE_INTERVAL"] || 5).to_i
      end
    end
  end
end
