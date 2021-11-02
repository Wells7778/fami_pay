module FamiPay
  class Config
    PRODUCTION_HOST = "https://payment-uat.pluspay.com.tw/Transaction/Gateway".freeze
    SANDBOX_HOST = "https://payment-uat.pluspay.com.tw/Transaction/Gateway".freeze

    attr_accessor :mode
    attr_accessor :secret_key
    attr_accessor :store_id

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