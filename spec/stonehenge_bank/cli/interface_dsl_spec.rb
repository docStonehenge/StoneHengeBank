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

      describe '#simple_calculations' do
        it 'sets up instance calculation_klass as InvestmentDecorator and yields' do
          expect { |b| subject.simple_calculations(&b) }.to yield_control

          expect(
            subject.instance_variable_get(:@calculation_klass)
          ).to eql Decorators::InvestmentDecorator
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
