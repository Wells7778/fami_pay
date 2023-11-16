# frozen_string_literal: true

require_relative 'base'

module FamiPay
  module Request
    class Payment < Base
      attr_writer :timeout, :buyer_id, :trade_number, :amount, :store_name

      def trade_time=(value_trade_time)
        @trade_time = value_trade_time if value_trade_time.is_a? String
        @trade_time ||= value_trade_time.strftime('%Y%m%d%H%M%S')
      end

      private

      def to_hash
        hash = super.merge({
                             Timeout: @timeout || 20,
                             BuyerID: @buyer_id,
                             OrderNo: @trade_number,
                             OrderCurrency: 'TWD',
                             OrderAmount: @amount,
                             OrderDT: @trade_time,
                             OrderTitle: @store_name
                           })
        hash[:BranchID] = branch_id if branch_id
        hash[:BranchName] = branch_name if branch_name
        hash
      end

      def request_type
        'tradeapi'
      end

      def request_action
        'payment'
      end
    end
  end
end
