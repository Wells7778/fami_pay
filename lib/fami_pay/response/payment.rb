# frozen_string_literal: true
require_relative "base"

module FamiPay
  module Response
    class Payment < Base

      def trade_number
        @OrderNo
      end

      def trade_time
        @OrderDT
      end

      def buyer_id
        @BuyerID
      end

      def bank_transaction_id
        @BankOrderNo
      end

      def transaction_time
        @BankOrderDT
      end

      def amount
        @OrderAmount
      end

      def real_amount
        @RealOrderAmount
      end

      def carrier
        @ReceiptDesc&.dig "InvoiceVehicle"
      end

    end
  end
end