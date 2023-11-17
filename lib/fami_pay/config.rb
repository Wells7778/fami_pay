module FamiPay
  class Config
    PRODUCTION_HOST = 'https://payment.pluspay.com.tw/Transaction/Gateway'.freeze
    SANDBOX_HOST = 'https://payment-uat.pluspay.com.tw/Transaction/Gateway'.freeze

    attr_accessor :mode, :secret_key, :store_id, :branch_id, :branch_name

    def initialize
      @mode = :sandbox
      @store_id = nil
      @secret_key = nil
    end

    def production?
      @mode != :sandbox
    end

    def api_host
      return PRODUCTION_HOST if production?

      SANDBOX_HOST
    end
  end
end
