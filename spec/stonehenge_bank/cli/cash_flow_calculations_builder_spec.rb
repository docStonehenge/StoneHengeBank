require 'spec_helper'

module StonehengeBank
  module Cli
    describe CashFlowCalculationsBuilder do
      it_behaves_like 'a DSL equivalency resolver'

      subject { described_class.new({}) }

      describe '#an_investment with_initial_cost:' do
        it 'sets an instance of CashFlow with its cost' do
          result = subject.an_investment with_initial_cost: 3200.0

          expect(result).to be_an_instance_of Resources::CashFlow
          expect(result.cost).to eql 3200.0
        end
      end

      describe '#has_returns_of *returns' do
        before do
          @cash_flow = subject.an_investment with_initial_cost: 3200.0
        end

        context 'when arguments are numbers' do
          it 'appends investments returns with future value to cash flow' do
            subject.has_returns_of 3200.0, 4000, 29_397.40

            expect(@cash_flow.investments.size).to eql 3

            @cash_flow.investments.each do |inv|
              expect(inv).to be_an_instance_of(Resources::Investment)
              expect([3200.0, 4000, 29397.40]).to include inv.future_value
            end
          end
        end

        context 'when any argument cannot be turned into a float ponting number' do
          it 'raises a cash flow calculation error' do
            expect {
              subject.has_returns_of "foo", "3400.0", "600_000.09235"
            }.to raise_error(
                   Resources::CashFlowError,
                   'An error occurred when trying to parse cash flow returns.'
                 )
          end
        end
      end
    end
  end
end
