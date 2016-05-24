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
        (@present_value * ((1 + equivalency.transformed_rate)**period)).round(2)
      end

      def calculated_present_value(equivalency, period)
        (@future_value / ((1 + equivalency.transformed_rate)**period)).round(2)
      end

      def calculated_investment_period(equivalency)
        check_investment_values!(:period)

        (Math.log(@future_value/@present_value) /
          Math.log(1 + equivalency.transformed_rate)).ceil
      end

      def calculated_investment_rate(period_kind, quantity)
        check_investment_values!(:interest_rate)
        matches_real_period_kind?(period_kind)

        ((((@future_value/@present_value)**(1/quantity.to_f)) - 1) * 100).round(2)
      end

      private

      def check_investment_values!(value_type)
        unless @present_value && @future_value
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
