require 'spec_helper'

describe 'Calculating simple payback for a cash flow', type: :aruba do
  it 'returns correct calculation, with full option names' do
    run_command(
      "stonehenge_bank simple_payback --init_cost=30000 --returns=2400 4000 15000 20000"
    )

    expect(command_output).to match('4')
  end

  it 'returns correct calculation, using aliases' do
    run_command(
      "stonehenge_bank simple_payback -c 30000 -r 2400 4000 15000 20000"
    )

    expect(command_output).to match('4')
  end

  it 'returns error message when initial cost is not present' do
    run_command(
      "stonehenge_bank net_present_value -r 2400 4000 15000 20000 -i '3,89% monthly' -o year"
    )

    expect(command_output).to match(
                                "No value provided for required options '--init-cost'"
                              )
  end

  it 'returns error message when returns are not present' do
    run_command(
      "stonehenge_bank net_present_value -c 30000 -i '3,89% monthly' -o year"
    )

    expect(command_output).to match(
                                "No value provided for required options '--returns'"
                              )
  end

  it 'returns correct help message when asked' do
    run_command(
      "stonehenge_bank help simple_payback"
    )

    expect(command_output).to eql(
                                <<-END
Usage:
  stonehenge_bank simple_payback -c, --init-cost=N -r, --returns=one two three

Options:
  -c, --init-cost=N            #  amount in floating_point notation
  -r, --returns=one two three  #  series of returns; each value as an amount in floating_point notation

Calculates simple payback for an investment
END
                              )
  end

  it 'returns error message when any return value is not a numeric value' do
    run_command(
      "stonehenge_bank simple_payback -c 30000 -r foo 4000 15000 20000"
    )

    expect(command_output).to match(
                                'An error occurred when trying to parse cash flow returns.'
                              )
  end
end
