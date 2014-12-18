require 'injectible'

describe Injectible::Inject do
  describe "injection via named parameters" do
    let(:klass) {
      Class.new do
        extend Injectible::Inject
        def initialize logger: nil, http: nil
          @logger = logger
          @http = http
        end
      end
    }

    let(:logger) { double :logger }
    let(:services) {{ logger: logger }}
    let(:injector) { Injectible::Injector.instance }

    around do |example|
      injector.services = services
      example.run
      injector.reset!
    end

    it "should call the initialize method" do
      expect(klass.new.instance_variables).to include :@logger, :@http
    end

    it "should pass a valid service" do
      logger = klass.new.instance_variable_get :@logger
      expect(logger).not_to be_nil
      expect(logger).to eq services[:logger]
    end

    it "should not pass values for non-service parameters" do
      logger = klass.new.instance_variable_get :@http
      expect(logger).to be_nil
    end
  end
end
