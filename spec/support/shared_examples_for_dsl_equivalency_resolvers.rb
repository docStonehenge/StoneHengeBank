shared_examples_for 'a DSL equivalency resolver' do
  it { is_expected.to respond_to :options }
  it { is_expected.to respond_to :interest_rate }
  it { is_expected.to respond_to :period }
  it { is_expected.to respond_to :equivalency }

  describe '#with_interest_rate rate_description' do
    it 'instantiates an InterestRate using builder as instance variable' do
      interest_rate = subject.with_interest_rate('2.48 annually')

      expect(subject.interest_rate).to eql interest_rate
      expect(interest_rate).to be_an_instance_of(StonehengeBank::Resources::InterestRate)
    end
  end

  describe '#return_on periodicity' do
    context 'when interest rate is present' do
      it "instantiates equivalency correctly" do
        subject.with_interest_rate('2.48 annually')
        subject.return_on as: :trimester

        expect(subject.equivalency).to be_an_instance_of(
                                         StonehengeBank::Calculators::TrimesterInterestEquivalency
                                       )
      end
    end

    context 'when interest rate is not present' do
      it "doesn't instantiate equivalency" do
        subject.return_on as: :year

        expect(subject.equivalency).to be_nil
      end
    end
  end

  describe '#validate_equivalency_presence!' do
    it 'halts execution when equivalency is present' do
      expect(subject).to receive(:equivalency).and_return double
      expect(subject.validate_equivalency_presence!).to be_nil
    end

    it 'raises EquivalencyMissingError when equivalency is not set' do
      expect(subject).to receive(:equivalency).and_return nil
      expect {
        subject.validate_equivalency_presence!
      }.to raise_error(StonehengeBank::DSL::EquivalencyMissingError)
    end
  end
end
