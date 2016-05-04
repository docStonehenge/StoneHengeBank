module StonehengeBank
  module Resources
    class Investment
      attr_reader :present_value, :future_value

      def initialize(interest_rate, present_value: nil, future_value: nil)
        @interest_rate = interest_rate
        @present_value = present_value
        @future_value  = future_value
      end

      def calculated_future_value(period, quantity)
        (@present_value * normalize_rate_based_on_period(period, quantity)).round(2)
      end

      def calculated_present_value(period, quantity)
        (@future_value / normalize_rate_based_on_period(period, quantity)).round(2)
      end

      private

      def normalize_rate_based_on_period(period, quantity)
        (1 + generated_period_equivalency(period).transformed_rate)**quantity
      end

      def generated_period_equivalency(period)
        StonehengeBank.const_get(
          "Calculators::#{period.capitalize}InterestEquivalency"
        ).new(@interest_rate)
      end
    end
  end
end
