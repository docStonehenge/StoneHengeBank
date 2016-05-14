module StonehengeBank
  module Calculators
    describe TrimesterInterestEquivalency do
      it_behaves_like 'an interest equivalency calculator'

      let(:interest_rate) { double(:interest_rate) }

      subject { described_class.new(interest_rate) }

      describe '#equivalent_rate_power' do
        specify 'when rate period is annually' do
          allow(interest_rate).to receive(:annually?).and_return true

          expect(subject.equivalent_rate_power).to eql 0.25
        end

        specify 'when rate period is semiannually' do
          allow(interest_rate).to receive(:annually?).and_return false
          allow(interest_rate).to receive(:semiannually?).and_return true

          expect(subject.equivalent_rate_power).to eql 0.5
        end

        specify 'when rate period is monthly' do
          allow(interest_rate).to receive(:annually?).and_return false
          allow(interest_rate).to receive(:semiannually?).and_return false
          allow(interest_rate).to receive(:monthly?).and_return true

          expect(subject.equivalent_rate_power).to eql 3
        end

        specify 'when rate period is daily' do
          allow(interest_rate).to receive(:annually?).and_return false
          allow(interest_rate).to receive(:semiannually?).and_return false
          allow(interest_rate).to receive(:monthly?).and_return false
          allow(interest_rate).to receive(:daily?).and_return true

          expect(subject.equivalent_rate_power).to eql 90
        end
      end

      describe '#matches_rate_period?' do
        it 'checks rate period if it is quarterly' do
          expect(interest_rate).to receive(:quarterly?)

          subject.matches_rate_period?
        end
      end
    end
  end
end
