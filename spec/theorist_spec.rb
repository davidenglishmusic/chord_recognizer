require 'theorist'

RSpec.describe Theorist do
  describe '#pitch_to_number' do
    it 'returns the correct number' do
      expect(Theorist.pitch_to_number('a sharp')).to eql(10)
    end

    it 'returns the correct number' do
      expect(Theorist.pitch_to_number('fb')).to eql(4)
    end
  end
end
