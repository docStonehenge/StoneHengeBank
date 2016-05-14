require 'simplecov'

SimpleCov.start do
  add_group 'Resources', 'lib/stonehenge_bank/resources'
  add_group 'Calculators', 'lib/stonehenge_bank/calculators'
  add_group 'Parsers', 'lib/stonehenge_bank/parsers'
end

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'stonehenge_bank'

Dir["spec/support/**/*.rb"].each { |f| load f }
