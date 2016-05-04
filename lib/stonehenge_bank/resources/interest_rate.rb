module StonehengeBank
  module Resources
    class InterestRate
      attr_reader :value, :period

      def initialize(value, period)
        @value, @period = value, period
      end

      def method_missing(method_name)
        if matches_real_period? method_name
          period.start_with? method_name.to_s.chomp('?')
        else
          super
        end
      end

      private

      def matches_real_period?(period_method)
        period_method =~ /annual|daily|month|semiannual|quarter/
      end
    end
  end
end
