# frozen_string_literal: true

require_relative 'base'

module FamiPay
  module Request
    class CreateBankQrcode < Base
      QRCODE_TYPE = 3

      attr_writer :order_id, :amount, :return_url, :confirm_url, :note

      def expire_time=(value_expire_time)
        @expire_time = value_expire_time if value_expire_time.is_a? String
        @expire_time ||= value_expire_time.strftime('%Y%m%d%H%M%S')
      end

      def for_pc!
        @online_trading = 0
      end

      private

      def post_initialize
        @online_trading = 1
      end

      def to_hash
        hash = super.merge({
                             Type: QRCODE_TYPE,
                             OrderNo: @order_id,
                             OrderCurrency: 'TWD',
                             OrderAmount: @amount,
                             ExpireDT: @expire_time,
                             StoreReturnUrl: @return_url,
                             StoreConfirmUrl: @confirm_url,
                             StoreMemo: @note,
                             OnlineTrading: @online_trading
                           })
        hash[:BranchID] = branch_id if branch_id
        hash[:BranchName] = branch_name if branch_name
        hash
      end

      def request_type
        'tradeapi'
      end

      def request_action
        'createbankqrcode'
      end
    end
  end
end
