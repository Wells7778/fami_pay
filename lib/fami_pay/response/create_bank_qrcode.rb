# frozen_string_literal: true
require_relative "base"

module FamiPay
  module Response
    class CreateBankQrcode < Base

      def payment_url
        @QRcode
      end

      def expire_time
        @ExpireDT
      end

    end
  end
end