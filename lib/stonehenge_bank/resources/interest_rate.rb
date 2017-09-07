module StonehengeBank
  module Resources
    class InterestRate
      class InvalidRatePeriodError < StandardError; end

      attr_reader :value, :period

      def initialize(value, period)
        @value, @period = value, period
      end

      def method_missing(method_name)
        if matches_real_period? method_name
          period.start_with? method_name.to_s.chomp('?')
        else
          raise InvalidRatePeriodError, 'Invalid value for interest rate. Valid periods are: annually, semiannually, quarterly, monthly and daily.'
        end
      end

      private

      def matches_real_period?(period_method)
        period_method =~ /annually|daily|monthly|semiannually|quarterly/
      end
    end
  end
end
