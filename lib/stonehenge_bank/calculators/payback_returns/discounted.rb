module StonehengeBank
  module Calculators
    module PaybackReturns
      class Discounted
        def initialize(interest_equivalency)
          @interest_equivalency = interest_equivalency
        end

        def return_value_from(investment, period)
          investment.calculated_present_value(@interest_equivalency, period)
        end
      end
    end
  end
end
