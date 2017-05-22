require 'spec_helper'

describe 'Calculating future value of an investment', type: :aruba do
  context 'when asking for numbers only' do
    it 'returns correct future value, with full options names' do
      run_command(
        "stonehenge_bank future_value --present_value=1000 --rate='3.89% monthly' --period=2 --periodicity='year'"
      )

      expect(command_output).to match("2499.02")
    end

    it 'returns correct future value, with aliases options' do
      run_command(
        "stonehenge_bank future_value -p 1000 -i '3.89% monthly' -n 2 -o 'year'"
      )

      expect(command_output).to match("2499.02")
    end
  end

  context 'when asking for verbosity' do
    it 'returns correct future value, with full options names' do
      run_command(
        "stonehenge_bank future_value --present_value=1000 --rate='3.89% monthly' --period=2 --periodicity='month' --verbose"
      )

      expect(
        command_output
      ).to match(
             "An investment with a present value of $1000, with an interest rate of 3.89%, on a period of 2 month(s), returns a future value of $1079.31."
           )
    end

    it 'returns correct future value, with aliases options' do
      run_command(
        "stonehenge_bank future_value -p 1000 -i '3.89% monthly' -n 2 -o 'month' -v"
      )

      expect(
        command_output
      ).to match(
             "An investment with a present value of $1000, with an interest rate of 3.89%, on a period of 2 month(s), returns a future value of $1079.31."
           )
    end
  end

  it 'returns message for missing present_value when not provided' do
    run_command(
      "stonehenge_bank future_value -i '3.89% monthly' -n 2 -o 'year'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--present-value'"
                              )
  end

  it 'returns message for missing rate when not provided' do
    run_command(
      "stonehenge_bank future_value -p 1000 -n 2 -o 'year'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--rate'"
                              )
  end

  it 'returns message for missing period when not provided' do
    run_command(
      "stonehenge_bank future_value -p 1000 -i '3.89% annually' -o 'day'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--period'"
                              )
  end

  it 'returns message for missing --periodicity option when not provided' do
    run_command(
      "stonehenge_bank future_value -p 1000 -i '3.89% annually' -n 2"
    )

    expect(command_output).to match(
                                "No value provided for required options '--periodicity'"
                              )
  end

  it 'returns correct help message when asked' do
    run_command(
      "stonehenge_bank help future_value"
    )

    expect(command_output).to eql(
                                <<-END
Usage:
  stonehenge_bank future_value -i, --rate=RATE -n, --period=N -o, --periodicity=PERIODICITY -p, --present-value=N

Options:
  -p, --present-value=N            #  amount in floating_point notation
  -i, --rate=RATE                  #  percentage amount and periodicity. LIKE: '2% annually'. Periodicity should be: 'annually', 'semiannually', 'quarterly', 'monthly', 'daily'.
  -n, --period=N                   #  amount in numeric notation
  -o, --periodicity=PERIODICITY    #  periodicity for result. Must be 'year', 'semester', 'trimester', 'month', 'day'
  -v, [--verbose], [--no-verbose]\s\s

Calculates future value of an investment
END
                              )
  end

  it 'returns friendly error message when rate option was send incomplete' do
    run_command(
      "stonehenge_bank future_value -p 1000 -i '3.89%' -n 2 -o 'year'"
    )

    expect(command_output).to match("Interest rate used is not parseable.")
  end

  it 'returns friendly error message when rate option was send wrongly' do
    run_command(
      "stonehenge_bank future_value -p 1000 -i '3.89% month' -n 2 -o 'year'"
    )

    expect(command_output).to match("Invalid value for interest rate.")
  end
end
