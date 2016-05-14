shared_examples_for 'an interest equivalency calculator' do
  let(:interest_rate) { double(:interest_rate, value: 0.15) }

  context 'interest equivalency interface' do
    it { is_expected.to respond_to(:transformed_rate) }
    it { is_expected.to respond_to(:equivalent_rate_power) }
    it { is_expected.to respond_to(:matches_rate_period?) }
  end

  describe '#transformed_rate' do
    it 'returns the interest rate value if rate period matches' do
      expect(subject).to receive(:matches_rate_period?).and_return true

      expect(subject.transformed_rate).to eql 0.15
    end

    it 'calculates rate equivalency if rate period does not match' do
      expect(subject).to receive(:matches_rate_period?).and_return false
      allow(subject).to receive(:equivalent_rate_power).and_return 3

      expect(subject.transformed_rate).to eql 0.52087
    end
  end
end
