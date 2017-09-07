module StonehengeBank
  module Cli
    module CommandMacros
      def define_method_options(*options)
        options.each do |option|
          send("option_for_#{option}")
        end
      end

      def option_for_present_value
        method_option(
          :present_value, type: :numeric, required: true,
          aliases: "-p", desc: banner_for_values(:floating_point)
        )
      end

      def option_for_future_value
        method_option(
          :future_value, type: :numeric, required: true,
          aliases: "-f", desc: banner_for_values(:floating_point)
        )
      end

      def option_for_init_cost
        method_option(
          :init_cost, type: :numeric, required: true, aliases: '-c',
          desc: banner_for_values(:floating_point)
        )
      end

      def option_for_returns
        method_option(
          :returns, type: :array, required: true, aliases: '-r',
          desc: " series of returns; each value as an#{banner_for_values(:floating_point)}"
        )
      end

      def option_for_period
        method_option(
          :period, type: :numeric, required: true,
          aliases: "-n", desc: banner_for_values(:numeric)
        )
      end

      def option_for_rate
        method_option(
          :rate, type: :string, required: true,
          aliases: "-i", desc: banner_for_rate_option
        )
      end

      def option_for_periodicity
        method_option(
          :periodicity, type: :string, required: true,
          aliases: "-o", desc: banner_for_result_periodicity
        )
      end

      def option_for_verbose
        method_option :verbose, type: :boolean, aliases: "-v"
      end

      def banner_for_values(type)
        " amount in #{type} notation"
      end

      def banner_for_rate_option
        " percentage amount and periodicity. LIKE: '2% annually'. Periodicity "\
        "should be: 'annually', 'semiannually', 'quarterly', 'monthly', 'daily'."
      end

      def banner_for_result_periodicity
        " periodicity for result. Must be 'year', 'semester', 'trimester', 'month', 'day'"
      end
    end
  end
end
