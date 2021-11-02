# frozen_string_literal: true

require_relative "fami_pay/version"
require_relative "fami_pay/request"
require_relative "fami_pay/response"
require_relative "fami_pay/config"

module FamiPay
  class Error < StandardError; end
end
