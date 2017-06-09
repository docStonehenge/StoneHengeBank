require 'spec_helper'

describe 'Calculating an investment rate for return', type: :aruba do
  context 'when asking for numbers only' do
    it 'returns correct rate, with full options names' do
      run_command(
        "stonehenge_bank investment_rate --present_value=100 --future_value=1000 --period=20"
      )

      expect(command_output).to match("0.12202")
    end

    it 'returns correct rate, with aliases options' do
      run_command(
        "stonehenge_bank investment_rate -p 100 -f 1000 -n 20"
      )

      expect(command_output).to match("0.12202")
    end
  end

  context 'when asking for verbosity' do
    it 'returns correct investment rate, with full options names' do
      run_command(
        "stonehenge_bank investment_rate --present_value=100 --future_value=1000 --period=20 --verbose"
      )

      expect(
        command_output
      ).to match(
             "An investment has present value of $100, has future value of $1000, on a period of 20 month(s), with an interest rate of 12.2%.\n"
           )
    end

    it 'returns correct investment rate, with aliases options' do
      run_command(
        "stonehenge_bank investment_rate -p 100 -f 1000 -n 20 -v"
      )

      expect(
        command_output
      ).to match(
             "An investment has present value of $100, has future value of $1000, on a period of 20 month(s), with an interest rate of 12.2%.\n"
           )
    end
  end

  it 'returns message for missing present_value when not provided' do
    run_command(
      "stonehenge_bank investment_rate -f 1000 -n 20"
    )

    expect(command_output).to match(
                                "No value provided for required options '--present-value'"
                              )
  end

  it 'returns message for missing future_value when not provided' do
    run_command(
      "stonehenge_bank investment_rate -p 100 -n 20"
    )

    expect(command_output).to match(
                                "No value provided for required options '--future-value'"
                              )
  end

  it 'returns message for missing --period option when not provided' do
    run_command(
      "stonehenge_bank investment_rate -p 100 -f 1000"
    )

    expect(command_output).to match(
                                "No value provided for required options '--period'"
                              )
  end

  it 'returns correct help message when asked' do
    run_command(
      "stonehenge_bank help investment_rate"
    )

    expect(command_output).to eql(
                                <<-END
Usage:
  stonehenge_bank investment_rate -f, --future-value=N -n, --period=N -p, --present-value=N

Options:
  -p, --present-value=N            #  amount in floating_point notation
  -f, --future-value=N             #  amount in floating_point notation
  -n, --period=N                   #  amount in numeric notation
  -v, [--verbose], [--no-verbose]\s\s

Calculates rate for investment return
END
                              )
  end
end
