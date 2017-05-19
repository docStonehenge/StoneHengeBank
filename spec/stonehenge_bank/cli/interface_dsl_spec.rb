require 'spec_helper'

module StonehengeBank
  module Cli
    describe InterfaceDSL do
      let(:investment)    { double(:investment) }
      let(:interest_rate) { double(:interest_rate) }
      let(:rate_builder)  { double(:interest_rate_builder) }
      let(:equivalency)   { double(:equivalency) }
      let(:decorator)     { double(:decorator) }
      let(:dsl_object)    { double(:dsl) }

      describe '#simple_calculations &block' do
        it 'sets up instance calculation_klass as InvestmentDecorator and yields' do
          expect { |b| subject.simple_calculations(&b) }.to yield_control

          expect(
            subject.instance_variable_get(:@calculation_klass)
          ).to eql Decorators::InvestmentDecorator
        end

        it 'returns any errors raised on evaluation' do
          expect(
            subject.simple_calculations do
              with_interest_rate '2.14'
            end
          ).to match /Interest rate used is not parseable/
        end
      end

      describe '#future_value verbosity' do
        before do
          subject.instance_variable_set(:@calculation_klass, Decorators::InvestmentDecorator)
          subject.an_investment with_present_value: 2000
          subject.with_interest_rate '2.14 annually'
          subject.on_period 3, :year

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

            subject.future_value(false)
          end
        end

        context 'when verbosity is true' do
          it 'calls #calculated_future_value_with_message on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_future_value_with_message
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency), 3)

            subject.future_value(true)
          end
        end
      end

      describe '#present_value verbosity' do
        before do
          subject.instance_variable_set(:@calculation_klass, Decorators::InvestmentDecorator)
          subject.an_investment with_future_value: 2000
          subject.with_interest_rate '2.14 annually'
          subject.on_period 3, :year

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

            subject.present_value(false)
          end
        end

        context 'when verbosity is true' do
          it 'calls #calculated_present_value_with_message on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_present_value_with_message
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency), 3)

            subject.present_value(true)
          end
        end
      end

      describe '#investment_period verbosity' do
        before do
          subject.instance_variable_set(:@calculation_klass, Decorators::InvestmentDecorator)
          subject.an_investment with_present_value: 200, with_future_value: 2000
          subject.with_interest_rate '2.14 annually'
          subject.on_period :year

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

            subject.investment_period(false)
          end
        end

        context 'when verbosity is true' do
          it 'calls #calculated_investment_period_with_message on decorator instance' do
            expect(decorator).to receive(
                                   :calculated_investment_period_with_message
                                 ).once.with(an_instance_of(Calculators::YearInterestEquivalency))

            subject.investment_period(true)
          end
        end
      end

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

      describe '#on_period period, periodicity' do
        it 'sets up period instance variable and instantiates a proper equivalency' do
          subject.with_interest_rate('2.48 annually')
          subject.on_period 3, :month

          expect(subject.period).to eql 3
          expect(subject.equivalency).to be_an_instance_of(Calculators::MonthInterestEquivalency)
        end

        it "doesn't set up equivalency when interest_rate isn't present" do
          subject.on_period 3, :month

          expect(subject.period).to eql 3
          expect(subject.equivalency).to be_nil
        end

        it "doesn't set period when it isn't present" do
          subject.with_interest_rate('2.48 annually')
          subject.on_period :trimester

          expect(subject.period).to be_nil
          expect(subject.equivalency).to be_an_instance_of(Calculators::TrimesterInterestEquivalency)
        end
      end
    end
  end
end
