require 'spec_helper'

module StonehengeBank
  module Resources
    describe CashFlow do
      let(:investment) { double(:investment) }

      subject { described_class.new(cost: 3_000) }

      it { is_expected.to have_attributes(cost: 3_000, investments: []) }

      describe '#append_investment_return investment' do
        it 'appends an investment into its collection' do
          subject.append_investment_return investment
          expect(subject.investments).to include investment
        end
      end
    end
  end
end
