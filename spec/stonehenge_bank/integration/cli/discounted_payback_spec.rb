require 'spec_helper'

describe 'Calculating discounted payback for a cash flow', type: :aruba do
  it 'returns correct calculation, with full option names' do
    run_command(
      "stonehenge_bank discounted_payback --init_cost=30000 --returns=2400 4000 15000 20000 --rate='0,0389% monthly' --periodicity=month"
    )

    expect(command_output).to match('4')
  end

  it 'returns correct calculation, using aliases' do
    run_command(
      "stonehenge_bank discounted_payback -c 30000 -r 2400 4000 15000 20000 -i '0,0389% monthly' -o month"
    )

    expect(command_output).to match('4')
  end

  it 'returns error message when initial cost is not present' do
    run_command(
      "stonehenge_bank discounted_payback -r 2400 4000 15000 20000 -i '3,89% monthly' -o year"
    )

    expect(command_output).to match(
                                "No value provided for required options '--init-cost'"
                              )
  end

  it 'returns error message when returns are not present' do
    run_command(
      "stonehenge_bank discounted_payback -c 30000 -i '3,89% monthly' -o year"
    )

    expect(command_output).to match(
                                "No value provided for required options '--returns'"
                              )
  end

  it 'returns error message when rate option is not present' do
    run_command(
      "stonehenge_bank discounted_payback -c 30000 -r 2400 4000 20000 -o year"
    )

    expect(command_output).to match(
                                "No value provided for required options '--rate'"
                              )
  end

  it 'returns error message when periodicity option is not present' do
    run_command(
      "stonehenge_bank discounted_payback -c 30000 -r 2400 4000 15000 20000 -i '3,89% monthly'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--periodicity'"
                              )
  end

  it 'returns correct help message when asked' do
    run_command(
      "stonehenge_bank help discounted_payback"
    )

    expect(command_output).to eql(
                                <<-END
Usage:
  stonehenge_bank discounted_payback -c, --init-cost=N -i, --rate=RATE -o, --periodicity=PERIODICITY -r, --returns=one two three

Options:
  -c, --init-cost=N              #  amount in floating_point notation
  -r, --returns=one two three    #  series of returns; each value as an amount in floating_point notation
  -i, --rate=RATE                #  percentage amount and periodicity. LIKE: '2% annually'. Periodicity should be: 'annually', 'semiannually', 'quarterly', 'monthly', 'daily'.
  -o, --periodicity=PERIODICITY  #  periodicity for result. Must be 'year', 'semester', 'trimester', 'month', 'day'

Calculates discounted payback for an investment
END
                              )
  end

  it 'returns error message when any return value is not a numeric value' do
    run_command(
      "stonehenge_bank discounted_payback -c 30000 -r foo 4000 15000 20000 -i '3,89% monthly' -o year"
    )

    expect(command_output).to match(
                                'An error occurred when trying to parse cash flow returns.'
                              )
  end

  it 'returns error message when rate option is incomplete' do
    run_command(
      "stonehenge_bank discounted_payback -c 30000 -r 4000 15000 20000 -i '3,89' -o year"
    )

    expect(command_output).to match(
                                "Interest rate used is not parseable."
                              )
  end

  it 'returns error message when rate option is invalid' do
    run_command(
      "stonehenge_bank discounted_payback -c 30000 -r 4000 15000 20000 -i '3,89% year' -o year"
    )

    expect(command_output).to match(
                                "Invalid value for interest rate."
                              )
  end

  it 'returns error message when periodicity option is invalid' do
    run_command(
      "stonehenge_bank discounted_payback -c 30000 -r 4000 15000 20000 -i '3,89% annually' -o bazz"
    )

    expect(command_output).to match(
                                "An attempt was made to set equivalency with invalid value."
                              )
  end
end
