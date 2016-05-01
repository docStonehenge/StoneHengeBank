module StonehengeBank
  module Calculators
    class InterestEquivalency
      attr_reader :period

      def initialize(interest_rate, for_period:)
        @interest_rate, @period = interest_rate, for_period
      end

      def transformed_rate
        raise NotImplementedError,
              'Subclasses must set #calculate_rate! with their own values and call here.'
      end

      private

      def calculate_rate!(quantity)
        (((1 + @interest_rate.value)**quantity - 1) * 100.0).round(2)
      end
    end
  end
end
