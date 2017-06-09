require 'spec_helper'

module StonehengeBank
  module Cli
    describe SimpleCalculationsBuilder do
      let(:investment)    { double(:investment) }
      let(:interest_rate) { double(:interest_rate) }
      let(:rate_builder)  { double(:interest_rate_builder) }
      let(:equivalency)   { double(:equivalency) }
      let(:decorator)     { double(:decorator) }

      specify do
        builder = described_class.new({})

        expect(
          builder.instance_variable_get(:@calculation_klass)
        ).to eql Decorators::InvestmentDecorator

        expect(builder).to have_attributes options: {}
      end

      subject { described_class.new({}) }

      describe '#an_investment with_present_value: nil, with_future_value: nil' do
        it 'instantiates an Investment with proper args as instance variable' do
          investment = subject.an_investment(with_present_value: 100.0)

          expect(subject.investment).to eql investment
          expect(investment).to be_an_instance_of(Resources::Investment)
          expect(investment.present_value).to eql 100.0
          expect(investment.future_value).to be_nil
        end
      end

      describe '#with_interest_rate rate_description' do
        it 'instantiates an InterestRate using builder as instance variable' do
          interest_rate = subject.with_interest_rate('2.48 annually')

          expect(subject.interest_rate).to eql interest_rate
          expect(interest_rate).to be_an_instance_of(Resources::InterestRate)
        end
      end

      describe '#return_on options' do
        context 'when interest rate is present' do
          context 'when period_of and as options are present' do
            it 'sets up period instance variable and instantiates a proper equivalency' do
              subject.with_interest_rate('2.48 annually')
              subject.return_on period_of: 3, as: :month

              expect(subject.period).to eql 3
              expect(subject.equivalency).to be_an_instance_of(Calculators::MonthInterestEquivalency)
            end
          end

          context 'when only as option is present' do
            it "just sets equivalency" do
              subject.with_interest_rate('2.48 annually')
              subject.return_on as: :trimester

              expect(subject.period).to be_nil
              expect(subject.equivalency).to be_an_instance_of(Calculators::TrimesterInterestEquivalency)
            end
          end

          context 'when only period_of option is present' do
            it "just sets period" do
              subject.with_interest_rate('2.48 annually')
              subject.return_on period_of: 3

              expect(subject.period).to eql 3
              expect(subject.equivalency).to be_nil
            end
          end
        end

        context 'when interest rate is not present' do
          context 'when period_of option is present' do
            it "just sets period" do
              subject.return_on period_of: 3

              expect(subject.period).to eql 3
              expect(subject.equivalency).to be_nil
            end
          end

          context 'when period_of and as options are present' do
            it "just sets period" do
              subject.return_on period_of: 3, as: :year

              expect(subject.period).to eql 3
              expect(subject.equivalency).to be_nil
            end
          end

          context 'when only as option is present' do
            it "doesn't set period nor equivalency" do
              subject.return_on as: :year

              expect(subject.period).to be_nil
              expect(subject.equivalency).to be_nil
            end
          end
        end
      end

      describe '#future_value verbose:' do
        before do
          subject.instance_variable_set(:@calculation_klass, Decorators::InvestmentDecorator)
          subject.an_investment with_present_value: 2000
          subject.with_interest_rate '2.14 annually'
          subject.return_on period_of: 3, as: :year

          expect(
            Decorators::InvestmentDecorator
          ).to receive(:new).once.with(
                 an_instance_of(Resources::Investment)
               ).and_return decorator
        end

        context 'when verbosity is false' do
          it 'calls #calculated_future_value on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_future_value
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency), 3)

            subject.future_value(verbose: false)
          end
        end

        context 'when verbosity is true' do
          it 'calls #calculated_future_value_with_message on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_future_value_with_message
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency), 3)

            subject.future_value(verbose: true)
          end
        end
      end

      describe '#present_value verbose:' do
        before do
          subject.instance_variable_set(:@calculation_klass, Decorators::InvestmentDecorator)
          subject.an_investment with_future_value: 2000
          subject.with_interest_rate '2.14 annually'
          subject.return_on period_of: 3, as: :year

          expect(
            Decorators::InvestmentDecorator
          ).to receive(:new).once.with(
                 an_instance_of(Resources::Investment)
               ).and_return decorator
        end

        context 'when verbosity is false' do
          it 'calls #calculated_present_value on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_present_value
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency), 3)

            subject.present_value(verbose: false)
          end
        end

        context 'when verbosity is true' do
          it 'calls #calculated_present_value_with_message on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_present_value_with_message
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency), 3)

            subject.present_value(verbose: true)
          end
        end
      end

      describe '#investment_period verbosity' do
        before do
          subject.instance_variable_set(:@calculation_klass, Decorators::InvestmentDecorator)
          subject.an_investment with_present_value: 200, with_future_value: 2000
          subject.with_interest_rate '2.14 annually'
          subject.return_on as: :year

          expect(
            Decorators::InvestmentDecorator
          ).to receive(:new).once.with(
                 an_instance_of(Resources::Investment)
               ).and_return decorator
        end

        context 'when verbosity is false' do
          it 'calls #calculated_investment_period on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_investment_period
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency))

            subject.investment_period(verbose: false)
          end
        end

        context 'when verbosity is true' do
          it 'calls #calculated_investment_period_with_message on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_investment_period_with_message
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency))

            subject.investment_period(verbose: true)
          end
        end
      end

      describe '#investment_rate verbose:' do
        before do
          subject.instance_variable_set(:@calculation_klass, Decorators::InvestmentDecorator)
          subject.an_investment with_present_value: 200, with_future_value: 2000
          subject.return_on period_of: 2

          expect(
            Decorators::InvestmentDecorator
          ).to receive(:new).once.with(
                 an_instance_of(Resources::Investment)
               ).and_return decorator
        end

        context 'when verbosity is false' do
          it 'calls #calculated_investment_rate on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_investment_rate
                                 ).once.with(2)

            subject.investment_rate(verbose: false)
          end
        end

        context 'when verbosity is true' do
          it 'calls #calculated_investment_rate_with_message on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_investment_rate_with_message
                                 ).once.with(2)

            subject.investment_rate(verbose: true)
          end
        end
      end

      describe '#regular_parcel verbose:' do
        before do
          subject.instance_variable_set(:@calculation_klass, Decorators::InvestmentDecorator)
          subject.an_investment with_present_value: 200, with_future_value: 2000
          subject.with_interest_rate '2.38 monthly'
          subject.return_on period_of: 2, as: :year

          expect(
            Decorators::InvestmentDecorator
          ).to receive(:new).once.with(
                 an_instance_of(Resources::Investment)
               ).and_return decorator
        end

        context 'when verbosity is false' do
          it 'calls #calculated_regular_parcel on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_regular_parcel
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency), 2)

            subject.regular_parcel(verbose: false)
          end
        end

        context 'when verbosity is true' do
          it 'calls #calculated_regular_parcel_with_message on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_regular_parcel_with_message
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency), 2)

            subject.regular_parcel(verbose: true)
          end
        end
      end
    end
  end
end
