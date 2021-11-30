# frozen_string_literal: true
require_relative "base"

module FamiPay
  module Request
    class CreateBankQrcode < Base

      QRCODE_TYPE = 3

      def order_id= value_order_id
        @order_id = value_order_id
      end

      def amount= value_amount
        @amount = value_amount
      end

      def expire_time= value_expire_time
        @expire_time = value_expire_time if value_expire_time.is_a? String
        @expire_time ||= value_expire_time.strftime('%Y%m%d%H%M%S')
      end

      def return_url= value_return_url
        @return_url = value_return_url
      end

      def confirm_url= value_confirm_url
        @confirm_url = value_confirm_url
      end

      def note= value_note
        @note = value_note
      end

      private

      def to_hash
        super.merge({
          Type: QRCODE_TYPE,
          OrderNo: @order_id,
          OrderCurrency: "TWD",
          OrderAmount: @amount,
          ExpireDT: @expire_time,
          StoreReturnUrl: @return_url,
          StoreConfirmUrl: @confirm_url,
          StoreMemo: @note,
          OnlineTrading: 1,
        })
      end

      def request_type
        "tradeapi"
      end

      def request_action
        "createbankqrcode"
      end

    end
  end
end