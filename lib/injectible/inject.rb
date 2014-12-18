module Injectible
  module Inject
    def new *args, &block
      obj = allocate
      params = nil
      services = Injector.instance.services

      obj.instance_eval { params = method(:initialize).parameters }
      params = params.inject({}) do |memo, (type, param)|
        if :key == type and services.keys.include? param
          memo[param] = services[param]
        end
        memo
      end

      args << params unless params.empty?
      obj.send :initialize, *args, &block
      obj
    end
  end
end
