# frozen_string_literal: true
require 'cgi'
require 'faraday'
require 'digest'
require 'json'

module FamiPay
  module Request
    class Base

      attr_accessor :config

      def initialize params=nil
        return unless params.is_a? Hash
        @config = nil
        params.each do |key, value|
          send "#{key}=", value
        end
        post_initialize
      end

      def request
        raise FamiPay::Error, "Missing Store ID" unless config&.store_id
        res = send_request
        "FamiPay::Response::#{self.class.name.demodulize}".constantize.new(res.body, raw: res, secret_key: config.secret_key)
      end

      private

      def post_initialize; end

      def to_hash
        {
          StoreID: config.store_id,
        }
      end

      def request_type
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def request_action
        raise NotImplementedError, "#{self.class} has not implemented method '#{__method__}'"
      end

      def request_data
        CGI.escape JSON.dump({
          Type: request_type,
          Action: request_action,
          TransactionData: encode_data,
          HashDigest: hash_data,
        })
      end

      def send_request
        Faraday.post api_host, request_data, "Content-Type" => "text/plain"
      end

      def encode_data
        @encode_data ||= CGI.escape JSON.dump(to_hash)
      end

      def hash_data
        Digest::SHA2.hexdigest("#{request_type}#{request_action}#{encode_data}#{secret_key}")
      end

      def secret_key
        config&.secret_key
      end

      def api_host
        config&.api_host
      end

    end
  end
end