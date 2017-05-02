require 'sendpulse_client/connection'

module SendpulseClient
  class Campaign
    URL = '/campaigns'.freeze

    class << self
      def all
        Connection.get_request(URL)
      end

      def create(sender_name, sender_email, subject, body, list_id, name = '', attachments = false)
        data = {
          sender_name: sender_name,
          sender_email: sender_email,
          subject: subject,
          body: Base64.encode64(body),
          list_id: list_id,
          name: name,
          attachments: attachments ? JSON.serialize(attachments) : ''
        }

        Connection.post_request(URL, data)
      end
    end
  end
end
