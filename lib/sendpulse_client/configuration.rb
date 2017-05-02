module SendpulseClient
  class Configuration
    attr_accessor :client_id, :client_secret

    def initialize
      @client_id = ''
      @client_secret = ''
    end
  end

  class << self
    attr_accessor :configuration

    def configure
      yield configuration
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
