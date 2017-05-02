require 'spec_helper'

RSpec.describe SendpulseClient::Connection::Token do
  subject { SendpulseClient::Connection::Token }

  let!(:token) { subject.new }

  before(:each) do
    allow(HTTParty).to receive(:post).and_return('access_token' => 'token')
    token.set!
  end

  it 'converts to valid string' do
    expect(token.to_s).to eq('Bearer token')
  end

  context '#valid' do
    it 'invalid after an hour' do
      token = subject.new('value', Time.now - 3601)
      expect(token.valid?).to(be false)
    end

    it 'valid for an hour' do
      expect(token.valid?).to(be true)
    end
  end
end
