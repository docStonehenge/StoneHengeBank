module StonehengeBank
  module Formatters
    class BaseMessageFormatter
      def initialize(investment, with_message: Messages::InvestmentMessage.new)
        @investment, @message = investment, with_message
      end

      def for_type(formatter_type)
        extend(Formatters.const_get(classified_formatter_type(formatter_type)))
      rescue NameError
        raise Formatters::FormatterNotFoundError,
              "#{formatter_type.to_s.capitalize} message formatter does not exist."
      end

      private

      def classified_formatter_type(type)
        "MessageFormatter".prepend(
          type.to_s.split('_').map(&:capitalize).join
        )
      end

      def humanized_value_type(type)
        type.to_s.tr('_', ' ')
      end

      def interest_rate_percentage_for(equivalency)
        (equivalency.transformed_rate * 100).round(2)
      end

      def formatted_periodicity_with(equivalency)
        equivalency.class.to_s.downcase.match(
          /year|semester|trimester|month|day/
        )[0]
      end
    end
  end
end
