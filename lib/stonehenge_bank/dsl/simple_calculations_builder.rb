module StonehengeBank
  module DSL
    class SimpleCalculationsBuilder
      include EquivalencyResolvable

      attr_reader :investment

      def initialize(options)
        @calculation_klass = Decorators::InvestmentDecorator
        @options           = options
      end

      def an_investment(with_present_value: nil, with_future_value: nil)
        @investment = Resources::Investment.new(
          present_value: with_present_value,
          future_value: with_future_value
        )
      end

      def return_on(periodicity)
        @period = periodicity.delete(:period_of)
        super
      end

      def future_value(verbose:)
        validate_equivalency_presence!

        call_calculation_on_decorator_instance(
          define_method_by_verbosity(:future_value, verbose),
          equivalency, period
        )
      end

      def present_value(verbose:)
        validate_equivalency_presence!

        call_calculation_on_decorator_instance(
          define_method_by_verbosity(:present_value, verbose),
          equivalency, period
        )
      end

      def investment_period(verbose:)
        validate_equivalency_presence!

        call_calculation_on_decorator_instance(
          define_method_by_verbosity(:investment_period, verbose),
          equivalency
        )
      end

      def investment_rate(verbose:)
        call_calculation_on_decorator_instance(
          define_method_by_verbosity(:investment_rate, verbose),
          period
        )
      end

      def regular_parcel(verbose:)
        validate_equivalency_presence!

        call_calculation_on_decorator_instance(
          define_method_by_verbosity(:regular_parcel, verbose),
          equivalency, period
        )
      end

      private

      def call_calculation_on_decorator_instance(*args)
        @calculation_klass.new(investment).public_send(*args)
      end

      def define_method_by_verbosity(calculation, verbosity)
        "calculated_#{calculation}".tap do |meth|
          meth << "_with_message" if verbosity
        end
      end
    end
  end
end
