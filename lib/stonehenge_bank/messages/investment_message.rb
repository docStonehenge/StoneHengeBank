module StonehengeBank
  module Messages
    class InvestmentMessage
      attr_reader :text

      def initialize
        @text = 'An investment'
      end

      def with_rate(rate)
        @text << " with an interest rate of #{rate}%,"
      end

      def with_period(periodicity, value)
        @text << " on a period of #{value} #{periodicity}(s),"
      end

      def with_value(value_type, value)
        @text << " with a #{value_type} of $#{value},"
      end

      def returns_value(value_type, value)
        @text << " returns a #{value_type} of $#{value}."
      end

      def has_value(value_type, value)
        @text << " has #{value_type} of $#{value}."
      end
    end
  end
end
