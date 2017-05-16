require 'thor'
require 'stonehenge_bank'
require 'stonehenge_bank/cli/command_macros'

module StonehengeBank
  module Cli
    class Interface < Thor
      extend CommandMacros

      desc 'future_value', 'Calculates future value of an investment'
      define_method_options(:present_value, :rate, :period, :on, :verbose)
      def future_value
        investment  = Resources::Investment.new(present_value: options.dig('present_value'))
        equivalency = Calculators.const_get(
          "#{options.dig('on').capitalize}InterestEquivalency"
        ).new(
          Builders::InterestRateBuilder.new(options.dig('rate')).construct_interest_rate
        )

        print Decorators::InvestmentDecorator.new(investment).public_send(
                determine_method_by_verbosity(:future_value),
                equivalency,
                options.dig('period').to_i
              )
      rescue => e
        print "There is an error with options used: #{e.message}"
      end

      private

      def determine_method_by_verbosity(calculation)
        return "calculated_#{calculation}_with_message" if options.dig('verbose')
        "calculated_#{calculation}"
      end
    end
  end
end
