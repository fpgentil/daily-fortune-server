module HealthCheck
  class ExternalConnection
    class << self

      def check_redis
        ok = false
        begin
          Sidekiq.redis do |conn|
            ok = true if conn.ping == "PONG"
          end
          ok
        rescue
          false
        end
      end

      def all
        {
          redis: check_redis,
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
