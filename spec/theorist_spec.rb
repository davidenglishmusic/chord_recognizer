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
    it 'itentifies the chord as a cluster if it does not recognize it' do
      cluster_chord = Theorist.create_chord([0, 1, 2, 9, 10])
      expect(Theorist.identify(cluster_chord)).to eql('tone cluster')
    end

    it 'itentifies the chord as a unison if it only contains one pitch' do
      unison_chord = Theorist.create_chord([0, 'c'])
      expect(Theorist.identify(unison_chord)).to eql('unison')
    end

    it 'itentifies a major second correctly' do
      dyad_chord = Theorist.create_chord([9, 11])
      expect(Theorist.identify(dyad_chord)).to eql('major second')
    end

    it 'itentifies a tritone correctly' do
      dyad_chord = Theorist.create_chord([1, 7])
      expect(Theorist.identify(dyad_chord)).to eql('tritone')
    end

    it 'itentifies a minor sixth correctly' do
      dyad_chord = Theorist.create_chord(['d', 'b flat'])
      expect(Theorist.identify(dyad_chord)).to eql('minor sixth')
    end

    it 'itentifies a major triad correctly' do
      major_triad = Theorist.create_chord(['d', 'f#', 'a'])
      expect(Theorist.identify(major_triad)).to eql('major triad')
    end

    it 'itentifies a minor triad correctly' do
      minor_triad = Theorist.create_chord(['b', 'f#', 'd'])
      expect(Theorist.identify(minor_triad)).to eql('minor triad')
    end

    it 'itentifies a diminished triad correctly' do
      diminished_triad = Theorist.create_chord(%w[a c eb])
      expect(Theorist.identify(diminished_triad)).to eql('diminished triad')
    end

    it 'itentifies an augmented triad correctly' do
      augmented_triad = Theorist.create_chord(%w[b g eb])
      expect(Theorist.identify(augmented_triad)).to eql('augmented triad')
    end

    it 'itentifies a major seventh correctly' do
      major_seventh_chord = Theorist.create_chord(%w[c e g b])
      expect(Theorist.identify(major_seventh_chord)).to eql('major seventh chord')
    end
  end

  describe '#pitches_combinations' do
    it 'returns the rotated combinations of the chord' do
      triad_chord = Theorist.create_chord(%w[d g bb])
      expect(Theorist.pitches_combinations(triad_chord.pitches))
        .to match_array([[2, 7, 10], [7, 10, 14], [10, 14, 19]])
    end
  end

  describe '#smallest_chord' do
    it 'returns the smallest combination of a chord' do
      triad_chord = Theorist.create_chord(%w[e a c#])
      expect(Theorist.smallest_chord(triad_chord.pitches))
        .to match_array([9, 13, 16])
    end
  end

  describe '#largest_chord' do
    it 'returns the smallest combination of a chord' do
      seventh_chord = Theorist.create_chord(%w[a d f# c#])
      expect(Theorist.largest_chord(seventh_chord.pitches))
        .to match_array([2, 6, 9, 13])
    end
  end

  describe '#interval_pattern' do
    it 'returns the interval pattern of a triad' do
      triad_chord = Theorist.create_chord(%w[c e g])
      expect(Theorist.interval_pattern(triad_chord.pitches))
        .to match_array([4, 7])
    end
  end
end
