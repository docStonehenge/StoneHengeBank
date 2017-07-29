module StonehengeBank
  module DSL
    module EquivalencyResolvable
      def self.included(_klass)
        attr_reader :options, :interest_rate, :period, :equivalency
      end

      def with_interest_rate(rate_description)
        @interest_rate = Builders::InterestRateBuilder.new(
          rate_description
        ).construct_interest_rate
      end

      def return_on(periodicity)
        @equivalency = Calculators::InterestEquivalency.get_equivalency_for(
          periodicity.delete(:as), interest_rate
        ) if periodicity[:as] and interest_rate
      end
    end
  end
end
