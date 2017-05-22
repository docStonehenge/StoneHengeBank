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
        opt = options

        result = InterfaceDSL.new.simple_calculations do
          an_investment      with_present_value: opt.dig('present_value')
          with_interest_rate opt.dig('rate')
          on_period          opt.dig('period'), opt.dig('periodicity')
          future_value       verbose: opt.dig('verbose')
        end

        print result
      end
    end
  end
end
