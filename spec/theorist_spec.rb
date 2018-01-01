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

  describe '#create_chord' do
    it 'creates a chord from numbers' do
      expect(Theorist.create_chord([5, 9, 0]).pitches).to match_array([0, 5, 9])
    end

    it 'creates a chord from named pitches' do
      expect(Theorist.create_chord(['a flat', 'c', 'd#']).pitches).to match_array([0, 3, 8])
    end

    it 'creates a chord with no duplicate pitches' do
      expect(Theorist.create_chord(['c', 0]).pitches).to eql([0])
    end
  end

  describe '#identify' do
    it 'classifies the chord as a cluster if it does not recognize it' do
      cluster_chord = Theorist.create_chord([0, 1, 2, 9, 10])
      expect(Theorist.identify(cluster_chord)).to eql('tone cluster')
    end
  end
end
