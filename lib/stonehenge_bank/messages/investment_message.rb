module StonehengeBank
  module Messages
    class InvestmentMessage
      attr_reader :message

      def initialize
        @message = 'An investment'
      end

      def with_rate(rate)
        @message << " with an interest rate of #{rate}%,"
        self
      end

      def with_period(periodicity, value)
        @message << " on a period of #{value} #{periodicity}(s),"
        self
      end

      def with_value(value_type, value)
        @message << " with a #{value_type} of $#{value},"
        self
      end

      def returns_value(value_type, value)
        @message << " returns a #{value_type} of $#{value}."
        self
      end

      def has_value(value_type, value)
        @message << " has #{value_type} of $#{value}."
        self
      end
    end
  end
end
