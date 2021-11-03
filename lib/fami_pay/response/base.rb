# frozen_string_literal: true
require 'cgi'
require 'digest'

module FamiPay
  module Response
    class Base
      SUCCESS = 0
      NONE = -1

      attr_reader :check_success

      def initialize encode_data, raw: nil, secret_key: nil
        @raw = raw
        @secret_key = secret_key
        raise FamiPay::Error, "Missing secret key" unless secret_key
        @params = JSON.parse CGI.unescape(encode_data) rescue {}
        check_hash
        response_data.each do |key, value|
          instance_variable_set(:"@#{key}", value)
        end if success?
      end

      def type
        @params["Type"]
      end

      def action
        @params["Action"]
      end

      def status
        @params["Status"]
      end

      def status_code
        return SUCCESS if status == "S"
        return NONE unless error_code
        error_code
      end

      def success?
        status == "S" && @check_success
      end

      def error_code
        @params["ErrorCode"] || ""
      end

      def error_message
        @params["ErrorDesc"] || ""
      end

      def response_data
        JSON.parse CGI.unescape(transaction_data) rescue {}
      end

      private

      def parse_time time_string
        return unless time_string
        "#{time_string[0, 4]}-#{time_string[4, 2]}-#{time_string[6, 2]} #{time_string[-6, 2]}:#{time_string[-4, 2]}:#{time_string[-2, 2]}".in_time_zone
      end

      def secret_key
        @secret_key
      end

      def check_hash
        @check_success = hash_digest == hash_data
      end

      def hash_data
        Digest::SHA2.hexdigest("#{type}#{action}#{status}#{error_code}#{error_message}#{transaction_data}#{secret_key}")
      end

      def transaction_data
        @params["TransactionData"] || ""
      end

      def hash_digest
        @params["HashDigest"]
      end

    end
  end
end