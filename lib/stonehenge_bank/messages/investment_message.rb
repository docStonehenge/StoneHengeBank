module StonehengeBank
  module Messages
    class InvestmentMessage
      attr_reader :text

      def initialize
        @text = 'An investment'
      end

      def with_rate(rate, separator: ',')
        @text << " with an interest rate of #{rate}%#{separator}"
      end

      def with_period(periodicity, value, separator: ',')
        @text << " on a period of #{value} #{periodicity}(s)#{separator}"
      end

      def with_value(value_type, value, separator: ',')
        @text << " with a #{value_type} of $#{value}#{separator}"
      end

      def returns_value(value_type, value, separator: '.')
        @text << " returns a #{value_type} of $#{value}#{separator}"
      end

      def has_value(value_type, value, separator: '.')
        @text << " has #{value_type} of $#{value}#{separator}"
      end
    end
  end
end
