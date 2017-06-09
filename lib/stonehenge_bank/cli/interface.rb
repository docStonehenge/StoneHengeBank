require 'thor'
require 'stonehenge_bank'
require 'stonehenge_bank/cli/command_macros'

module StonehengeBank
  module Cli
    class Interface < Thor
      extend CommandMacros

      desc 'future_value', 'Calculates future value of an investment'
      define_method_options(:present_value, :rate, :period, :periodicity, :verbose)
      def future_value
        result = InterfaceDSL.simple_calculations(with_options: options) do
          an_investment      with_present_value: options.dig('present_value')
          with_interest_rate options.dig('rate')
          return_on          period_of: options.dig('period'), as: options.dig('periodicity')
          future_value       verbose: options.dig('verbose')
        end

        puts result
      end

      desc 'present_value', 'Calculates present value of an investment'
      define_method_options(:future_value, :rate, :period, :periodicity, :verbose)
      def present_value
        result = InterfaceDSL.simple_calculations(with_options: options) do
          an_investment      with_future_value: options.dig('future_value')
          with_interest_rate options.dig('rate')
          return_on          period_of: options.dig('period'), as: options.dig('periodicity')
          present_value      verbose: options.dig('verbose')
        end

        puts result
      end

      desc 'investment_period', 'Calculates the period for investment return'
      define_method_options(:present_value, :future_value, :rate, :periodicity, :verbose)
      def investment_period
        result = InterfaceDSL.simple_calculations(with_options: options) do
          an_investment with_present_value: options.dig('present_value'), with_future_value: options.dig('future_value')
          with_interest_rate options.dig('rate')
          return_on          as: options.dig('periodicity')
          investment_period  verbose: options.dig('verbose')
        end

        puts result
      end
    end
  end
end
