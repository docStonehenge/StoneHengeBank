module StonehengeBank
  module Decorators
    class InvestmentDecorator
      def initialize(investment)
        @investment = investment
      end

      def method_missing(method_name, *args)
        if @investment.respond_to? method_name
          @investment.public_send(method_name, *args)
        else
          Formatters::BaseMessageFormatter.new(@investment).for_type(
            formatter_type_based_on_method_name(method_name)
          ).calculation_with_message(*args)
        end
      end

      private

      def formatter_type_based_on_method_name(method)
        method.to_s.match(/calculated_(\w+)_with/)[1]
      end
    end
  end
end
