require 'spec_helper'

module StonehengeBank
  module DSL
    describe CashFlowCalculationsBuilder do
      it_behaves_like 'a DSL equivalency resolver'

      subject { described_class.new({}) }

      describe '#an_investment with_initial_cost:' do
        it 'sets an instance of CashFlow with its cost' do
          subject.an_investment with_initial_cost: 3200.0

          expect(subject.cash_flow).to be_an_instance_of Resources::CashFlow
          expect(subject.cash_flow.cost).to eql 3200.0
        end

        it 'raises cash flow error when cost is not parseable' do
          expect {
            subject.an_investment with_initial_cost: 'foo'
          }.to raise_error(Resources::CashFlowError, 'An error occurred when trying to parse cash flow cost.')
        end
      end

      describe '#has_returns_of *returns' do
        context 'when cash flow instance is set' do
          before do
            subject.an_investment with_initial_cost: 3200.0
          end

          context 'when arguments are numbers' do
            it 'appends investments returns with future value to cash flow' do
              subject.has_returns_of 3200.0, 4000, 29_397.40

              expect(subject.cash_flow.investments.size).to eql 3

              subject.cash_flow.investments.each do |inv|
                expect(inv).to be_an_instance_of(Resources::Investment)
                expect([3200.0, 4000, 29397.40]).to include inv.future_value
              end
            end
          end

          context 'when any argument cannot be turned into a float ponting number' do
            it 'raises a cash flow error' do
              expect {
                subject.has_returns_of "foo", "3400.0", "600_000.09235"
              }.to raise_error(
                     Resources::CashFlowError,
                     'An error occurred when trying to parse cash flow returns.'
                   )
            end
          end
        end

        context "when cash flow isn't set" do
          it 'raises runtime error with proper message' do
            expect {
              subject.has_returns_of 3200.0, 4000, 29_397.40
            }.to raise_error(RuntimeError, 'Cash flow calculation was not properly built: Cash flow instance is missing.')
          end
        end
      end

      describe '#net_present_value' do
        context 'when cash flow instance is set' do
          before do
            subject.an_investment(with_initial_cost: 300_000)
            subject.has_returns_of 3200.0, 4000, 29_397.40
          end

          it 'calls calculation on cash_flow instance with NetPresentValue calculator' do
            subject.with_interest_rate '3.89% annually'
            subject.return_on as: :year

            expect(subject.cash_flow).to receive(
                                           :net_present_value
                                         ).once.with(
                                           an_instance_of(Calculators::NetPresentValue),
                                           with_rate_equivalency: an_instance_of(Calculators::YearInterestEquivalency)
                                         ).and_return 10

            expect(subject.net_present_value).to eql 10
          end

          it 'raises ArgumentError with message when just rate is set' do
            subject.with_interest_rate '3.89% annually'

            expect {
              subject.net_present_value
            }.to raise_error(ArgumentError, 'Interest rate equivalency is missing')
          end

          it 'raises ArgumentError with message when just return option is set' do
            subject.return_on as: :year

            expect {
              subject.net_present_value
            }.to raise_error(ArgumentError, 'Interest rate equivalency is missing')
          end
        end

        context "when cash flow isn't set" do
          it 'raises runtime error with proper message' do
            expect {
              subject.net_present_value
            }.to raise_error(RuntimeError, 'Cash flow calculation was not properly built: Cash flow instance is missing.')
          end
        end
      end

      describe '#simple_payback' do
        let(:simple_payback) { double(:payback) }

        context 'when cash flow is set for operation' do
          before do
            subject.an_investment(with_initial_cost: 300_000)
            subject.has_returns_of 3200.0, 4000, 29_397.40
          end

          it 'calls payback on cash_flow instance with simple Payback calculator' do
            expect(
              Calculators::Payback
            ).to receive(:simple).once.and_return simple_payback

            expect(
              subject.cash_flow
            ).to receive(:payback_period).once.with(simple_payback).and_return 3

            expect(subject.simple_payback).to eql 3
          end
        end

        context "when cash flow isn't set" do
          it 'raises runtime error with proper message' do
            expect {
              subject.simple_payback
            }.to raise_error(RuntimeError, 'Cash flow calculation was not properly built: Cash flow instance is missing.')
          end
        end
      end
    end
  end
end
