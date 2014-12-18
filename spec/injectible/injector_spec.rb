require "injectible"

describe Injectible::Injector do
  subject(:injector) { described_class.instance }

  it { should respond_to :services }
  it { should respond_to :services= }
  it { should respond_to :default_services }
  it { should respond_to :reset! }

  describe "default services" do
    subject { injector.services.keys }
    it { should match_array [ :logger, :http ]}
  end

  describe "::services=" do
    let(:app) { double :app }
    let(:logger) { double :logger }
    let(:services) {{ logger: logger, app: app }}

    around do |example|
      injector.services = services
      example.run
      injector.reset!
    end

    it "should set the injector's services" do
      expect(injector.services).to eq services
    end
  end
end
