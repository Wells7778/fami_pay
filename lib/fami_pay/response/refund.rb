# frozen_string_literal: true
require_relative "base"

module FamiPay
  module Response
    class Refund < Base

      def trade_number
        @OrderNo
      end

      def trade_time
        @OrderDT
      end

      def refund_bank_transaction_id
        @BankRefundOrderNo
      end

      def refund_time
        parse_time @BankRefundOrderDT
      end

      def amount
        @RefundOrderAmount
      end

    end
  end
end