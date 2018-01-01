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
      expect(Theorist.create_chord(['c', 0]).pitches).to match_array([0])
    end
  end

  describe '#identify' do
    it 'classifies the chord as a cluster if it does not recognize it' do
      cluster_chord = Theorist.create_chord([0, 1, 2, 9, 10])
      expect(Theorist.identify(cluster_chord)).to eql('tone cluster')
    end

    it 'classifies the chord as a unison if it only contains one pitch' do
      unison_chord = Theorist.create_chord([0, 'c'])
      expect(Theorist.identify(unison_chord)).to eql('unison')
    end

    it 'classifies a major second correctly' do
      dyad_chord = Theorist.create_chord([9, 11])
      expect(Theorist.identify(dyad_chord)).to eql('major second')
    end

    it 'classifies a tritone correctly' do
      dyad_chord = Theorist.create_chord([1, 7])
      expect(Theorist.identify(dyad_chord)).to eql('tritone')
    end

    it 'classifies a minor sixth correctly' do
      dyad_chord = Theorist.create_chord(['d', 'b flat'])
      expect(Theorist.identify(dyad_chord)).to eql('minor sixth')
    end
  end
end
