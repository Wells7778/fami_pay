# frozen_string_literal: true
require_relative "base"

module FamiPay
  module Request
    class Query < Base

      def trade_number= value_trade_number
        @trade_number = value_trade_number
      end

      private

      def to_hash
        super.merge({
          Timeout: @timeout || 20,
          OrderNo: @trade_number,
        })
      end

      def request_type
        "tradeapi"
      end

      def request_action
        "query"
      end

    end
  end
end