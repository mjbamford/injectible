require "logger"
require "net/http"
require "singleton"

module Injectible
  class Injector
    include Singleton

    DEFAULT_SERVICES = Hash[
      logger: (::Logger.new STDOUT),
      http: Net::HTTP
    ]

    def services
      @services ||= DEFAULT_SERVICES
    end

    def default_services
      DEFAULT_SERVICES
    end

    def services= services
      @services = services if services.respond_to? :[]
      @services
    end

    def reset!
      @services = nil
    end
  end
end
