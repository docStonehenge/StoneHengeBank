module StonehengeBank
  module Parsers
    class InterestRateParser
      class RateNotParseable < StandardError; end

      def initialize(rate)
        @rate = rate.tr(',%', '. ').split(/\s+/)

        if @rate.first.to_f.zero?
          raise RateNotParseable, 'The string typed is not parseable.'
        end
      end

      def construct_interest_rate
        Resources::InterestRate.new(rate_value, @rate[1])
      end

      private

      def rate_value
        (@rate[0].to_f / 100.0).round(5)
      end
    end
  end
end
