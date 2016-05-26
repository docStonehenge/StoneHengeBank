module StonehengeBank
  module Formatters
    class PresentValueMessageFormatter
      include BaseMessageFormatter

      def initialize(investment)
        @investment = investment
      end

      def current_value_type
        :future_value
      end

      def value_to_reach_type
        :present_value
      end

      def calculation_with_message(equivalency, period)
        super(equivalency, period) do |message|
          message % { message_verb: 'has to have' }
        end
      end
    end
  end
end
