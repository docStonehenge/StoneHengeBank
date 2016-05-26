require "stonehenge_bank/version"

require 'ostruct'

require "stonehenge_bank/resources/interest_rate"
require "stonehenge_bank/resources/investment"
require "stonehenge_bank/calculators/interest_equivalency"
require "stonehenge_bank/calculators/year_interest_equivalency"
require 'stonehenge_bank/calculators/semester_interest_equivalency'
require 'stonehenge_bank/calculators/trimester_interest_equivalency'
require 'stonehenge_bank/calculators/month_interest_equivalency'
require 'stonehenge_bank/calculators/day_interest_equivalency'
require "stonehenge_bank/builders/interest_rate_builder"
require "stonehenge_bank/decorators/investment_decorator"
require "stonehenge_bank/formatters/base_message_formatter"
require "stonehenge_bank/formatters/future_value_message_formatter"
require "stonehenge_bank/formatters/present_value_message_formatter"

module StonehengeBank

end
