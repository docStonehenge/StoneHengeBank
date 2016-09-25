module StonehengeBank
  module Resources
    class Investment
      attr_accessor :present_value, :future_value

      def initialize(present_value: nil, future_value: nil)
        @present_value, @future_value = present_value, future_value
      end

      def calculated_future_value(equivalency, period)
        raise ::UncalculableInvestmentValueError,
              'Cannot calculate future value without a present value.' unless present_value

        self.future_value = (
          present_value * period_power_calculated_rate(equivalency, period)
        ).round(2)
      end

      def calculated_present_value(equivalency, period)
        raise ::UncalculableInvestmentValueError,
              'Cannot calculate present value without a future value.' unless future_value

        self.present_value = (
          future_value / period_power_calculated_rate(equivalency, period)
        ).round(2)
      end

      def calculated_investment_period(equivalency)
        check_investment_values!(:period)

        (Math.log(future_value/present_value) /
          Math.log(neutralized_rate_for(equivalency))).ceil
      end

      def calculated_investment_rate(period)
        check_investment_values!(:interest_rate)

        (((future_value/present_value)**(1/period.to_f)) - 1).round 5
      end

      def calculated_regular_parcel(equivalency, period)
        check_investment_values!(:regular_parcel)

        (
          (future_value - (present_value * period_power_calculated_rate(equivalency, period))) /
          ((period_power_calculated_rate(equivalency, period) - 1) / equivalency.transformed_rate)
        ).round 2
      end

      private

      def neutralized_rate_for(equivalency)
        1 + equivalency.transformed_rate
      end

      def period_power_calculated_rate(equivalency, period)
        neutralized_rate_for(equivalency)**period
      end

      def check_investment_values!(calculation_type)
        unless present_value && future_value
          raise ::UncalculableInvestmentValueError,
                "Cannot calculate #{calculation_type.to_s.gsub('_', ' ')} with null values."
        end
      end
    end
  end
end
