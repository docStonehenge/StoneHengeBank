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
          raise InvalidRatePeriodError, 'This is not a valid period for a rate. Valid periods are: annually, semiannually, quarterly, monthly and daily.'
        end
      end

      private

      def matches_real_period?(period_method)
        period_method =~ /annual|daily|month|semiannual|quarter/
      end
    end
  end
end
