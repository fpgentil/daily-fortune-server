module HealthCheck
  class ExternalConnection
    class << self

      def check_mongo
        begin
          if Mongoid.default_session.command(ping: 1).present?
            true
          else
            false
          end
        rescue Exception => e
          false
        end
      end

      def check_redis
        begin
          Sidekiq.redis do |conn|
            if conn.ping == "PONG"
              true
            else
              false
            end
          end
        rescue
          false
        end
      end

      def all
        {
          redis: check_redis,
          mongo: check_mongo
        }
      end

      def failure?
        faiure = false
        all.each do |service, connection_ok|
          faiure = true if connection_ok == false
        end
        return faiure
      end

      def ok?
        return !failure?
      end
    end
  end
end
