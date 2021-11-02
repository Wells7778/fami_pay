# frozen_string_literal: true
require_relative "base"

module FamiPay
  module Response
    class Result < Base

      def store_id
        @StoreID
      end

      def payment_url
        @QRcode
      end

      def notify_time
        @NotifyTime
      end

      def order_id
        @OrderNo
      end

      def bank_transaction_id
        @BankOrderNo
      end

      def amount
        @OrderAmount
      end

      def note
        @StoreMemo
      end

      def carrier
        @ReceiptDesc&.dig "InvoiceVehicle"
      end

      def status
        "S"
      end

      private

      def hash_data
        Digest::SHA2.hexdigest("#{transaction_data}#{secret_key}")
      end

    end
  end
end