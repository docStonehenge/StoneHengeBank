module StonehengeBank
  module Builders
    class InterestRateBuilder
      class RateNotParseable < StandardError; end

      def initialize(rate)
        @rate = rate.tr(',%', '. ').split(/\s+/)

        if @rate.first.to_f.zero? or @rate[1].nil?
          raise RateNotParseable, 'Interest rate used is not parseable.'
        end
      end

      def construct_interest_rate
        Resources::InterestRate.new(rate_value, period = @rate[1]).tap do |rate|
          rate.public_send("#{period}?")
        end
      end

      private

      def rate_value
        (@rate[0].to_f / 100.0).round(5)
      end
    end
  end
end
