require 'stonehenge_bank/resources/interest_rate'

module StonehengeBank
  module Parsers
    class InterestRateParser
      def initialize(rate)
        @rate = rate.split(/\%\s+/)
      end

      def construct_interest_rate
        Resources::InterestRate.new(rate_value, @rate[1])
      end

      private

      def rate_value
        @rate[0].to_f / 100.0
      end
    end
  end
end
