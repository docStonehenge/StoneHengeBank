require 'spec_helper'

describe 'Calculating regular parcel value from an investment', type: :aruba do
  context 'when asking for numbers only' do
    it 'returns the value for investment regular parcel, with full options names' do
      run_command(
        "stonehenge_bank regular_parcel --present_value=100 --future_value=1000 --rate '1.25% annually' --period=20 --periodicity=month"
      )

      expect(command_output).to match("44.45")
    end

    it 'returns correct rate, with aliases options' do
      run_command(
        "stonehenge_bank regular_parcel -p 100 -f 1000 -i '1.25% annually' -n 20 -o month"
      )

      expect(command_output).to match("44.45")
    end
  end

  context 'when asking for verbosity' do
    it 'returns correct investment regular parcel, with full options names' do
      run_command(
        "stonehenge_bank regular_parcel --present_value=100 --future_value=1000 --rate='1.25% annually' --period=20 --periodicity=month --verbose"
      )

      expect(
        command_output
      ).to match(
             "An investment with a present value of $100, has future value of $1000, with an interest rate of 0.1%, on a period of 20 month(s), with a regular parcel of $44.45.\n"
           )
    end

    it 'returns correct investment regular parcel, with aliases options' do
      run_command(
        "stonehenge_bank regular_parcel -p 100 -f 1000 -i '1.25% annually' -n 20 -o month -v"
      )

      expect(
        command_output
      ).to match(
             "An investment with a present value of $100, has future value of $1000, with an interest rate of 0.1%, on a period of 20 month(s), with a regular parcel of $44.45.\n"
           )
    end
  end


  it 'returns message for missing present_value when not provided' do
    run_command(
      "stonehenge_bank regular_parcel -f 1000 -i '3.89% monthly' -n 20 -o 'year'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--present-value'"
                              )
  end

  it 'returns message for missing future_value when not provided' do
    run_command(
      "stonehenge_bank regular_parcel -p 100 -i '3.89% monthly' -n 15 -o 'year'"
    )

    expect(command_output).to match(
                                "No value provided for required options '--future-value'"
                              )
  end

  it 'returns message for missing rate when not provided' do
    run_command(
      "stonehenge_bank regular_parcel -p 100 -f 1000 -n 24 -o month"
    )

    expect(command_output).to match(
                                "No value provided for required options '--rate'"
                              )
  end

  it 'returns message for missing --period option when not provided' do
    run_command(
      "stonehenge_bank regular_parcel -p 100 -f 1000 -i '3.89% annually' -o month"
    )

    expect(command_output).to match(
                                "No value provided for required options '--period'"
                              )
  end

  it 'returns message for missing --periodicity option when not provided' do
    run_command(
      "stonehenge_bank regular_parcel -p 100 -f 1000 -i '3.89% annually' -n 16"
    )

    expect(command_output).to match(
                                "No value provided for required options '--periodicity'"
                              )
  end

  it 'returns correct help message when asked' do
    run_command(
      "stonehenge_bank help regular_parcel"
    )

    expect(command_output).to eql(
                                <<-END
Usage:
  stonehenge_bank regular_parcel -f, --future-value=N -i, --rate=RATE -n, --period=N -o, --periodicity=PERIODICITY -p, --present-value=N

Options:
  -p, --present-value=N            #  amount in floating_point notation
  -f, --future-value=N             #  amount in floating_point notation
  -i, --rate=RATE                  #  percentage amount and periodicity. LIKE: '2% annually'. Periodicity should be: 'annually', 'semiannually', 'quarterly', 'monthly', 'daily'.
  -n, --period=N                   #  amount in numeric notation
  -o, --periodicity=PERIODICITY    #  periodicity for result. Must be 'year', 'semester', 'trimester', 'month', 'day'
  -v, [--verbose], [--no-verbose]\s\s

Calculates the regular parcel returned from an investment
END
                              )
  end

  it 'returns friendly error message when rate option was send incomplete' do
    run_command(
      "stonehenge_bank regular_parcel -p 100 -f 1000 -i '3.89%' -n 12 -o 'year'"
    )

    expect(command_output).to match("Interest rate used is not parseable.")
  end

  it 'returns friendly error message when rate option was send wrongly' do
    run_command(
      "stonehenge_bank regular_parcel -p 100 -f 1000 -i '3.89% month' -n 24 -o 'year'"
    )

    expect(command_output).to match("Invalid value for interest rate.")
  end

  it 'returns friendly error message when periodicity option is invalid' do
    run_command(
      "stonehenge_bank regular_parcel -p 100 -f 1000 -i '3.89% monthly' -n 24 -o 'foo'"
    )

    expect(command_output).to match("An attempt was made to set equivalency with invalid value.")
  end
end
