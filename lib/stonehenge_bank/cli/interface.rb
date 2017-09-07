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
        print_result_of(
          build_simple_calculation_for(:future_value, :present_value, options)
        )
      end

      desc 'present_value', 'Calculates present value of an investment'
      define_method_options(:future_value, :rate, :period, :periodicity, :verbose)
      def present_value
        print_result_of(
          build_simple_calculation_for(:present_value, :future_value, options)
        )
      end

      desc 'investment_period', 'Calculates the period for investment return'
      define_method_options(:present_value, :future_value, :rate, :periodicity, :verbose)
      def investment_period
        print_result_of(
          DSL::Interface.simple_calculations(with_options: options) do
            an_investment with_present_value: options.dig('present_value'), with_future_value: options.dig('future_value')
            with_interest_rate options.dig('rate')
            return_on as: options.dig('periodicity')
            investment_period verbose: options.dig('verbose')
          end
        )
      end

      desc 'investment_rate', 'Calculates rate for investment return'
      define_method_options(:present_value, :future_value, :period, :verbose)
      def investment_rate
        print_result_of(
          DSL::Interface.simple_calculations(with_options: options) do
            an_investment with_present_value: options.dig('present_value'), with_future_value: options.dig('future_value')
            return_on period_of: options.dig('period')
            investment_rate verbose: options.dig('verbose')
          end
        )
      end

      desc 'regular_parcel', 'Calculates the regular parcel returned from an investment'
      define_method_options(:present_value, :future_value, :rate, :period, :periodicity, :verbose)
      def regular_parcel
        print_result_of(
          DSL::Interface.simple_calculations(with_options: options) do
            an_investment with_present_value: options.dig('present_value'), with_future_value: options.dig('future_value')
            with_interest_rate options.dig('rate')
            return_on period_of: options.dig('period'), as: options.dig('periodicity')
            regular_parcel verbose: options.dig('verbose')
          end
        )
      end

      desc 'net_present_value', 'Calculates net present value for an investment'
      define_method_options(:init_cost, :returns, :rate, :periodicity)
      def net_present_value
        print_result_of(build_cash_flow_calculation_for(:net_present_value))
      end

      desc 'simple_payback', 'Calculates simple payback for an investment'
      define_method_options(:init_cost, :returns)
      def simple_payback
        print_result_of(
          DSL::Interface.cash_flow_calculations(with_options: options) do
            an_investment with_initial_cost: options.dig('init_cost')
            has_returns_of(*options.dig('returns'))
            simple_payback
          end
        )
      end

      desc 'discounted_payback', 'Calculates discounted payback for an investment'
      define_method_options(:init_cost, :returns, :rate, :periodicity)
      def discounted_payback
        print_result_of(build_cash_flow_calculation_for(:discounted_payback))
      end

      private

      def build_simple_calculation_for(name, required_value, options)
        DSL::Interface.simple_calculations(with_options: options) do
          an_investment :"with_#{required_value}" => options.dig(required_value.to_s)
          with_interest_rate options.dig('rate')
          return_on period_of: options.dig('period'), as: options.dig('periodicity')
          public_send(name, verbose: options.dig('verbose'))
        end
      end

      def build_cash_flow_calculation_for(name)
        DSL::Interface.cash_flow_calculations(with_options: options) do
          an_investment with_initial_cost: options.dig('init_cost')
          with_interest_rate options.dig('rate')
          has_returns_of(*options.dig('returns'))
          return_on as: options.dig('periodicity')
          public_send(name)
        end
      end

      def options
        super.merge(raise_errors: false)
      end

      def print_result_of(calculation)
        puts calculation
      end
    end
  end
end
