require 'sendpulse_client/connection'

module SendpulseClient
  class Addressbook
    URL = '/addressbooks'.freeze

    class << self
      def all
        Connection.get_request(URL)
      end

      def create(name)
        Connection.post_request(URL, bookName: name)
      end

      def clients(book_id, offset = '', limit = '')
        params = {
          offset: offset,
          limit: limit
        }

        Connection.get_request("#{URL}/#{book_id}/emails", params)
      end

      def add_clients(book_id, clients)
        emails = JSON.generate(clients)
        Connection.post_request("#{URL}/#{book_id}/emails", emails: emails)
      end

      def delete_clients(emails)
        Connection.delete_request("#{URL}/emails", emails: JSON.generate(emails))
      end

      def get_client(book_id, email)
        Connection.get_request("#{URL}/#{book_id}/emails/#{email}")
      end
    end
  end
end
