require 'sendpulse_client/connection'

module SendpulseClient
  class Email
    URL = '/emails'.freeze

    class << self
      def get(email)
        Connection.get_request("#{URL}/#{email}")
      end

      def delete(email)
        Connection.delete_request("#{URL}/#{email}")
      end
    end
  end
end
