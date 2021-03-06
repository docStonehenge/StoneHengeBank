require 'spec_helper'

module StonehengeBank
  module DSL
    describe Interface do
      let(:investment)    { double(:investment) }
      let(:interest_rate) { double(:interest_rate) }
      let(:rate_builder)  { double(:interest_rate_builder) }
      let(:equivalency)   { double(:equivalency) }
      let(:decorator)     { double(:decorator) }
      let(:dsl_object)    { double(:dsl) }

      describe '.simple_calculations with_options: { raise_errors: true }, &block' do
        it 'sets SimpleCalculationsBuilder and yields to receive its commands' do
          expect(
            SimpleCalculationsBuilder
          ).to receive(:new).once.with({ raise_errors: true })

          expect do |b|
            described_class.simple_calculations(&b)
          end.to yield_control
        end

        it 'raises error on evaluation by default' do
          expect {
            described_class.simple_calculations do
              with_interest_rate '2.14'
            end
          }.to raise_error(Builders::InterestRateBuilder::RateNotParseable)
        end

        it 'returns any errors raised on evaluation' do
          expect(
            described_class.simple_calculations(with_options: { raise_errors: false }) do
              with_interest_rate '2.14'
            end
          ).to match /Interest rate used is not parseable/
        end
      end

      describe '.cash_flow_calculations with_options: { raise_errors: true }, &block' do
        it 'sets CashFlowCalculationsBuilder and yields to receive its commands' do
          expect(
            CashFlowCalculationsBuilder
          ).to receive(:new).once.with({ raise_errors: true })

          expect do |b|
            described_class.cash_flow_calculations(&b)
          end.to yield_control
        end

        it 'raises error on evaluation by default' do
          expect {
            described_class.cash_flow_calculations do
              an_investment with_initial_cost: 300000
              with_interest_rate '2.14 annually'
              discounted_payback
            end
          }.to raise_error(EquivalencyMissingError)
        end

        it 'returns any errors raised on evaluation' do
          expect(
            described_class.cash_flow_calculations(with_options: { raise_errors: false }) do
              an_investment with_initial_cost: 300000
              with_interest_rate '2.14 annually'
              discounted_payback
            end
          ).to match /Interest rate equivalency is missing./
        end
      end
    end
  end
end
