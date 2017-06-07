require 'spec_helper'

describe 'Calculating present value of an investment', type: :aruba do
  context 'when asking for numbers only' do
    it 'returns correct present value, with full options names' do
      run_command(
        "stonehenge_bank present_value --future_value=1000 --rate='3.89% monthly' --period=2 --periodicity='year'"
      )

      expect(command_output).to match("400.16")
    end

    it 'returns correct present value, with aliases options' do
      run_command(
        "stonehenge_bank present_value -f 1000 -i '3.89% monthly' -n 2 -o 'year'"
      )

      expect(command_output).to match("400.16")
    end
  end

  context 'when asking for verbosity' do
    it 'returns correct present value, with full options names' do
      run_command(
        "stonehenge_bank present_value --future_value=1000 --rate='3.89% monthly' --period=2 --periodicity='year' --verbose"
      )

      expect(
        command_output
      ).to match(
             "An investment with a future value of $1000, with an interest rate of 58.08%, on a period of 2 year(s), has present value of $400.16."
           )
    end

    it 'returns correct present value, with aliases options' do
      run_command(
        "stonehenge_bank present_value -f 1000 -i '3.89% monthly' -n 2 -o 'year' -v"
      )

      expect(
        command_output
      ).to match(
             "An investment with a future value of $1000, with an interest rate of 58.08%, on a period of 2 year(s), has present value of $400.16."
           )
    end
  end

  it 'returns message for missing future_value when not provided' do
    run_command(
      "stonehenge_bank present_value -i '3.89% monthly' -n 2 -o 'year'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--future-value'"
                              )
  end

  it 'returns message for missing rate when not provided' do
    run_command(
      "stonehenge_bank present_value -f 1000 -n 2 -o 'year'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--rate'"
                              )
  end

  it 'returns message for missing period when not provided' do
    run_command(
      "stonehenge_bank present_value -f 1000 -i '3.89% annually' -o 'day'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--period'"
                              )
  end

  it 'returns message for missing --periodicity option when not provided' do
    run_command(
      "stonehenge_bank present_value -f 1000 -i '3.89% annually' -n 2"
    )

    expect(command_output).to match(
                                "No value provided for required options '--periodicity'"
                              )
  end

  it 'returns correct help message when asked' do
    run_command(
      "stonehenge_bank help present_value"
    )

    expect(command_output).to eql(
                                <<-END
Usage:
  stonehenge_bank present_value -f, --future-value=N -i, --rate=RATE -n, --period=N -o, --periodicity=PERIODICITY

Options:
  -f, --future-value=N             #  amount in floating_point notation
  -i, --rate=RATE                  #  percentage amount and periodicity. LIKE: '2% annually'. Periodicity should be: 'annually', 'semiannually', 'quarterly', 'monthly', 'daily'.
  -n, --period=N                   #  amount in numeric notation
  -o, --periodicity=PERIODICITY    #  periodicity for result. Must be 'year', 'semester', 'trimester', 'month', 'day'
  -v, [--verbose], [--no-verbose]\s\s

Calculates present value of an investment
END
                              )
  end

  it 'returns friendly error message when rate option was send incomplete' do
    run_command(
      "stonehenge_bank present_value -f 1000 -i '3.89%' -n 2 -o 'year'"
    )

    expect(command_output).to match("Interest rate used is not parseable.")
  end

  it 'returns friendly error message when rate option was send wrongly' do
    run_command(
      "stonehenge_bank present_value -f 1000 -i '3.89% month' -n 2 -o 'year'"
    )

    expect(command_output).to match("Invalid value for interest rate.")
  end

  it 'returns friendly error message when periodicity option is invalid' do
    run_command(
      "stonehenge_bank present_value -f 1000 -i '3.89% monthly' -n 2 -o 'foo'"
    )

    expect(command_output).to match("An attempt was made to set equivalency with invalid value.")
  end
end
