module SendpulseClient
  class Connection
    include HTTParty
    base_uri 'https://api.sendpulse.com/'
    format :json
    require 'logger'

    Token = Struct.new(:value, :created_at) do
      URL = 'https://api.sendpulse.com/oauth/access_token'.freeze

      def initialize(value = nil, created_at = nil)
        @value = value
        @created_at = created_at
      end

      def set!
        body = {
          client_id: SendpulseClient.configuration.client_id,
          client_secret: SendpulseClient.configuration.client_secret,
          grant_type: 'client_credentials'
        }

        @value = HTTParty.post(URL, logger: Rails.logger, body: body)['access_token']
        @created_at = Time.now
      end

      def to_s
        "Bearer #{@value}"
      end

      def valid?
        (Time.now - @created_at) / 3600 < 1.0
      end
    end

    class << self
      def get_request(path, data = {})
        params = {
          query: data,
          headers: auth_headers
        }

        get(path, params).parsed_response
      end

      def post_request(path, data = {})
        body = {
          body: data,
          headers: auth_headers
        }

        post(path, body).parsed_response
      end

      def delete_request(path, body = {})
        body = {
          body: data,
          headers: auth_headers
        }

        delete(path, body).parsed_response
      end

      private

      def auth_headers
        { 'Authorization' => token.to_s }
      end

      def token
        if @token && @token.valid?
          @token
        else
          @token = Token.new
          @token.set!
          @token
        end
      end
    end
  end
end
