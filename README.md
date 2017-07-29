# StoneHengeBank

StoneHengeBank is a SAMPLE application desgined to do fast investment calculations, with friendly verbose responses, allowing the user to understand better what an investment can provide.

(WIP) An easy-to-use command-line interface runs a calculation on values of an investment, such as: interest rate, future and present values, regular parcels, return periods.

Via a Domain-Specific Language, it's possible to have results returned for a client application using this gem.

## Installation

(WIP) This gem is not yet published on <a href="https://rubygems.org">RubyGems</a>, so it's necessary to clone/fork this repo to use it, for now.

Add this line to your application's Gemfile:

```ruby
  gem 'stonehenge_bank'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install stonehenge_bank

## Usage

### (WIP) Command-Line Interface:

To use the command-line interface, the gem provides several commands.

Future value:

    $ stonehenge_bank future_value --present_value=1000 --rate='3.89% monthly' --period=2 --periodicity='year'
    # This command calculates a future value of an investment with present value of 1000, with interest rate of 3.89% monthly, in a return period of 2 year.
    # You can use abbreviated flags for this command. Check via:
    $ stonehenge_bank help future_value

Present value:

    $ stonehenge_bank present_value --future_value=1000 --rate='3.89% monthly' --period=2 --periodicity='year'
    # This command calculates a present value of an investment with future value of 1000, with interest rate of 3.89% monthly, in a return period of 2 year.
    # You can use abbreviated flags for this command. Check via:
    $ stonehenge_bank help present_value

Investment period:

    $ stonehenge_bank investment_period --present_value=100 --future_value=1000 --rate='3.89% monthly' --periodicity=year
    # This command calculates the investment return period, in years, of an investment with present value of 100, future value of 1000, and interest rate of 3.89% monthly.
    # You can use abbreviated flags for this command. Check via:
    $ stonehenge_bank help investment_period

Investment rate:

    $ stonehenge_bank investment_rate --present_value=100 --future_value=1000 --period=20
    # This command calculates the investment rate of an investment with present value of 100, future value of 1000 in a period of 20 (months).
    # You can use abbreviated flags for this command. Check via:
    $ stonehenge_bank help investment_rate

Investment regular parcel:

    $ stonehenge_bank regular_parcel --present_value=100 --future_value=1000 --rate '1.25% annually' --period=20 --periodicity=month
    # This command calculates the regular parcel paid by an investment with present value of 100, future value of 1000 in a period of 20 months, rating 1.25% annually.
    # You can use abbreviated flags for this command. Check via:
    $ stonehenge_bank help regular_parcel

### Domain-Specific Language inside applications:

StoneHengeBank provides an easy and clarified DSL to be used on applications that depend upon it.

Although it's possible to use the verbosity level with it (set `:verbose` argument to true), most cases will only need to run numeric results.

Future value:

```ruby
          StonehengeBank::DSL::Interface.simple_calculations do
            an_investment      with_present_value: 100.0
            with_interest_rate "3.89% monthly"
            return_on          period_of: 2, as: "year"
            future_value       verbose: false
          end
```

Present value:

```ruby
          StonehengeBank::DSL::Interface.simple_calculations do
            an_investment      with_future_value: 1500.0
            with_interest_rate "3.89% monthly"
            return_on          period_of: 2, as: "year"
            present_value       verbose: false
          end
```

Investment period:

```ruby
          StonehengeBank::DSL::Interface.simple_calculations do
            an_investment with_present_value: 100.0, with_future_value: 4780.0
            with_interest_rate "1.7% annually"
            return_on as: "year"
            investment_period verbose: false
          end
```

Investment rate:

```ruby
          StonehengeBank::DSL::Interface.simple_calculations do
            an_investment with_present_value: 1200.99, with_future_value: 130_470.99
            return_on period_of: 36
            investment_rate verbose: false
          end
```

Investment regular parcel:

```ruby
          StonehengeBank::DSL::Interface.simple_calculations do
            an_investment with_present_value: 159.70, with_future_value: 1300.0
            with_interest_rate "0.079% monthly"
            return_on period_of: 12, as: "month"
            regular_parcel verbose: false
          end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec stonehenge_bank` to use the gem in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Testing

`StoneHengeBank` has a test suite based on integration tests for CLI commands and unit tests.
In order to run the test suite, just run:

    $ rspec

or

    $ bundle exec rspec

## Contributing

Bug reports and pull requests are welcome. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
