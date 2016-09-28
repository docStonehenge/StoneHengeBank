module StonehengeBank
  module Calculators
    module PaybackReturns
      class Simple
        def return_value_from(investment, _period)
          investment.future_value
        end
      end
    end
  end
end
