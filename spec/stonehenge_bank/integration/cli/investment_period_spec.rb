require 'spec_helper'

describe 'Calculating the necessary period for investment return', type: :aruba do
  context 'when asking for numbers only' do
    it 'returns correct period value, with full options names' do
      run_command(
        "stonehenge_bank investment_period --present_value=100 --future_value=1000 --rate='3.89% monthly' --periodicity=year"
      )

      expect(command_output).to match("5.03")
    end

    it 'returns correct period value, with aliases options' do
      run_command(
        "stonehenge_bank investment_period -p 100 -f 1000 -i '3.89% monthly' -o 'year'"
      )

      expect(command_output).to match("5.03")
    end
  end

  context 'when asking for verbosity' do
    it 'returns correct investment period, with full options names' do
      run_command(
        "stonehenge_bank investment_period --present_value=100 --future_value=1000 --rate='3.89% monthly' --periodicity='year' --verbose"
      )

      expect(
        command_output
      ).to match(
             "An investment has present value of $100, has future value of $1000, with an interest rate of 58.08%, on a period of 5.03 year(s).\n"
           )
    end

    it 'returns correct investment period, with aliases options' do
      run_command(
        "stonehenge_bank investment_period -p 100 -f 1000 -i '3.89% monthly' -o 'year' -v"
      )

      expect(
        command_output
      ).to match(
             "An investment has present value of $100, has future value of $1000, with an interest rate of 58.08%, on a period of 5.03 year(s).\n"
           )
    end
  end

  it 'returns message for missing present_value when not provided' do
    run_command(
      "stonehenge_bank investment_period -f 1000 -i '3.89% monthly' -o 'year'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--present-value'"
                              )
  end

  it 'returns message for missing future_value when not provided' do
    run_command(
      "stonehenge_bank investment_period -p 100 -i '3.89% monthly' -o 'year'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--future-value'"
                              )
  end

  it 'returns message for missing rate when not provided' do
    run_command(
      "stonehenge_bank investment_period -p 100 -f 1000 -o 'year'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--rate'"
                              )
  end

  it 'returns message for missing --periodicity option when not provided' do
    run_command(
      "stonehenge_bank investment_period -p 100 -f 1000 -i '3.89% annually'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--periodicity'"
                              )
  end

  it 'returns correct help message when asked' do
    run_command(
      "stonehenge_bank help investment_period"
    )

    expect(command_output).to eql(
                                <<-END
Usage:
  stonehenge_bank investment_period -f, --future-value=N -i, --rate=RATE -o, --periodicity=PERIODICITY -p, --present-value=N

Options:
  -p, --present-value=N            #  amount in floating_point notation
  -f, --future-value=N             #  amount in floating_point notation
  -i, --rate=RATE                  #  percentage amount and periodicity. LIKE: '2% annually'. Periodicity should be: 'annually', 'semiannually', 'quarterly', 'monthly', 'daily'.
  -o, --periodicity=PERIODICITY    #  periodicity for result. Must be 'year', 'semester', 'trimester', 'month', 'day'
  -v, [--verbose], [--no-verbose]\s\s

Calculates the period for investment return
END
                              )
  end

  it 'returns friendly error message when rate option was send incomplete' do
    run_command(
      "stonehenge_bank investment_period -p 100 -f 1000 -i '3.89%' -o 'year'"
    )

    expect(command_output).to match("Interest rate used is not parseable.")
  end

  it 'returns friendly error message when rate option was send wrongly' do
    run_command(
      "stonehenge_bank investment_period -p 100 -f 1000 -i '3.89% month' -o 'year'"
    )

    expect(command_output).to match("Invalid value for interest rate.")
  end

  it 'returns friendly error message when periodicity option is invalid' do
    run_command(
      "stonehenge_bank investment_period -p 100 -f 1000 -i '3.89% monthly' -o 'foo'"
    )

    expect(command_output).to match("An attempt was made to set equivalency with invalid value.")
  end
end
