module StonehengeBank
  module Resources
    class Investment
      class UncalculableInvestmentValueError < StandardError; end

      attr_accessor :present_value, :future_value

      def initialize(present_value: nil, future_value: nil)
        @present_value = present_value
        @future_value  = future_value
      end

      def calculated_future_value(equivalency, period)
        raise UncalculableInvestmentValueError,
              'Cannot calculate future value without a present value.' unless present_value

        (present_value * period_power_calculated_rate(equivalency, period)).round(2)
      end

      def calculated_present_value(equivalency, period)
        raise UncalculableInvestmentValueError,
              'Cannot calculate present value without a future value.' unless future_value

        (future_value / period_power_calculated_rate(equivalency, period)).round(2)
      end

      def calculated_investment_period(equivalency)
        check_investment_values!(:period)

        (Math.log(future_value/present_value) /
          Math.log(neutralized_rate_for(equivalency))).ceil
      end

      def calculated_investment_rate(period_kind, quantity)
        check_investment_values!(:interest_rate)
        matches_real_period_kind?(period_kind)

        ((((future_value/present_value)**(1/quantity.to_f)) - 1) * 100).round(2)
      end

      def calculated_investment_regular_parcel(equivalency, period)
        raise UncalculableInvestmentValueError,
              'Cannot calculate parcel without a future value.' unless future_value

        (
          future_value / (
            neutralized_rate_for(equivalency) * (
              (
                (period_power_calculated_rate(equivalency, period)) - 1
              ) / equivalency.transformed_rate
            )
          )
        ).round 2
      end

      private

      def neutralized_rate_for(equivalency)
        1 + equivalency.transformed_rate
      end

      def period_power_calculated_rate(equivalency, period)
        neutralized_rate_for(equivalency)**period
      end

      def check_investment_values!(value_type)
        unless present_value && future_value
          raise UncalculableInvestmentValueError,
                "Cannot calculate #{value_type.to_s.gsub('_', ' ')} with null values."
        end
      end

      def matches_real_period_kind?(period_kind)
        if period_kind !~ /year|semester|half|trimester|quarter|month|day/
          raise UncalculableInvestmentValueError,
                'Cannot calculate interest rate with an invalid period.'
        end
      end
    end
  end
end
