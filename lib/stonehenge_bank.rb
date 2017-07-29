require "stonehenge_bank/version"

require 'ostruct'

require "stonehenge_bank/resources/interest_rate"
require "stonehenge_bank/resources/investment"
require "stonehenge_bank/resources/cash_flow_error"
require "stonehenge_bank/resources/cash_flow"
require "stonehenge_bank/resources/uncalculable_investment_value_error"
require "stonehenge_bank/calculators/net_present_value"
require "stonehenge_bank/calculators/payback"
require "stonehenge_bank/calculators/payback_returns/simple"
require "stonehenge_bank/calculators/payback_returns/discounted"
require "stonehenge_bank/calculators/invalid_interest_equivalency_error"
require "stonehenge_bank/calculators/interest_equivalency"
require "stonehenge_bank/calculators/year_interest_equivalency"
require 'stonehenge_bank/calculators/semester_interest_equivalency'
require 'stonehenge_bank/calculators/trimester_interest_equivalency'
require 'stonehenge_bank/calculators/month_interest_equivalency'
require 'stonehenge_bank/calculators/day_interest_equivalency'
require "stonehenge_bank/builders/interest_rate_builder"
require "stonehenge_bank/decorators/investment_decorator"
require "stonehenge_bank/messages/investment_message"
require "stonehenge_bank/formatters/formatter_not_found_error"
require "stonehenge_bank/formatters/base_message_formatter"
require "stonehenge_bank/formatters/future_value_message_formatter"
require "stonehenge_bank/formatters/present_value_message_formatter"
require "stonehenge_bank/formatters/investment_period_message_formatter"
require "stonehenge_bank/formatters/investment_rate_message_formatter"
require "stonehenge_bank/formatters/regular_parcel_message_formatter"

require "stonehenge_bank/cli/equivalency_resolvable"
require "stonehenge_bank/cli/simple_calculations_builder"
require "stonehenge_bank/cli/cash_flow_calculations_builder"
require "stonehenge_bank/cli/interface_dsl"

module StonehengeBank

end
