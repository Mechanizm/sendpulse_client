module SendpulseClient
  class Configuration
    attr_accessor :client_id, :client_secret, :logger

    def initialize
      @client_id = ''
      @client_secret = ''
      @logger = Rails.logger
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
