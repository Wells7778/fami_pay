# frozen_string_literal: true
require_relative "base"

module FamiPay
  module Request
    class Refund < Base

      def timeout= value_timeout
        @timeout = value_timeout
      end

      def bank_transaction_id= value_bank_transaction_id
        @bank_transaction_id = value_bank_transaction_id
      end

      def amount= value_amount
        @amount = value_amount
      end

      private

      def to_hash
        super.merge({
          Timeout: @timeout || 20,
          BankOrderNo: @bank_transaction_id,
          RefundOrderAmount: @amount,
        })
      end

      def request_type
        "tradeapi"
      end

      def request_action
        "refund"
      end

    end
  end
end