module StonehengeBank
  module Decorators
    class InvestmentDecorator
      def initialize(investment)
        @investment = investment
      end

      def method_missing(method_name, *args)
        if method_ends_with?('_with_message', method_name) and formatter_exists? method_name
          Formatters::BaseMessageFormatter.new(@investment).for_type(
            formatter_type_based_on_method_name(method_name)
          ).calculation_with_message(*args)
        elsif method_ends_with?('_value', method_name) and @investment.respond_to? method_name
          @investment.public_send(method_name, *args)
        else
          super
        end
      end

      private

      def method_ends_with?(suffix, method_name)
        method_name.to_s.end_with? suffix
      end

      def formatter_type_based_on_method_name(method)
        method.to_s.match(/calculated_(\w+)_with/)[1]
      end

      def formatter_exists?(type)
        Formatters.const_defined?(
          "#{formatter_type_based_on_method_name(type).split('_').map(&:capitalize).join}MessageFormatter"
        )
      end
    end
  end
end
