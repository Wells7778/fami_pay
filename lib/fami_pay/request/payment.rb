# frozen_string_literal: true
require_relative "base"

module FamiPay
  module Request
    class Payment < Base

      def timeout= value_time_out
        @timeout = value_time_out
      end

      def buyer_id= value_buyer_id
        @buyer_id = value_buyer_id
      end

      def trade_number= value_trade_number
        @trade_number = value_trade_number
      end

      def amount= value_amount
        @amount = value_amount
      end

      def trade_time= value_trade_time
        @trade_time = value_trade_time if value_trade_time.is_a? String
        @trade_time ||= value_trade_time.strftime('%Y%m%d%H%M%S')
      end

      def store_name= value_store_name
        @store_name = value_store_name
      end

      private

      def to_hash
        super.merge({
          Timeout: @timeout || 20,
          BuyerID: @buyer_id,
          OrderNo: @trade_number,
          OrderCurrency: "TWD",
          OrderAmount: @amount,
          OrderDT: @trade_time,
          OrderTitle: @store_name,
        })
      end

      def request_type
        "tradeapi"
      end

      def request_action
        "payment"
      end

    end
  end
end