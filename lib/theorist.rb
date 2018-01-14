require 'chord'

class Theorist
  PITCH_NUMBER_MAP =
    {
      'c' => 0,
      'c#' => 1,
      'c sharp' => 1,
      'db' => 1,
      'd flat' => 1,
      'd' => 2,
      'd#' => 3,
      'd sharp' => 3,
      'eb' => 3,
      'e flat' => 3,
      'e' => 4,
      'e#' => 5,
      'e sharp' => 5,
      'fb' => 4,
      'f flat' => 4,
      'f' => 5,
      'f#' => 6,
      'f sharp' => 6,
      'gb' => 6,
      'g flat' => 6,
      'g' => 7,
      'g#' => 8,
      'g sharp' => 8,
      'ab' => 8,
      'a flat' => 8,
      'a' => 9,
      'a#' => 10,
      'a sharp' => 10,
      'bb' => 10,
      'b flat' => 10,
      'b' => 11,
      'cb' => 11,
      'c flat' => 11
    }.freeze

  INTERVAL_MAP =
    {
      1 => 'minor second',
			2 => 'major second',
      3 => 'minor third',
      4 => 'major third',
      5 => 'perfect fourth',
      6 => 'tritone',
      7 => 'perfect fifth',
      8 => 'minor sixth',
      9 => 'major sixth',
      10 => 'minor seventh',
      11 => 'major seventh'
    }.freeze

  TRIAD_INTERVAL_MAP =
    {
      [4, 7] => 'major',
      [3, 7] => 'minor',
      [3, 6] => 'diminished',
      [4, 8] => 'augmented',
      [2, 7] => 'sus2',
      [5, 7] => 'sus4'
    }.freeze

  SEVENTH_CHORD_INTERVAL_MAP =
    {
      [4, 7, 11] => 'major',
      [4, 7, 10] => 'major minor',
      [3, 7, 10] => 'minor',
      [3, 6, 10] => 'half diminished',
      [3, 6, 9] => 'diminished'
    }.freeze

  def self.pitch_to_number(pitch)
    PITCH_NUMBER_MAP[pitch]
  end

  def self.create_chord(pitches)
    pitch_numbers = pitches.map do |pitch|
      if pitch.is_a? Integer
        pitch
      else
        pitch_to_number(pitch)
      end
    end
    Chord.new(pitch_numbers.uniq.sort)
  end

  def self.identify(chord)
    case chord.pitches.length
    when 4
      result = SEVENTH_CHORD_INTERVAL_MAP[interval_pattern(largest_chord(chord.pitches))]
      return result + ' seventh chord' if result
      'tone cluster'
    when 3
      result = TRIAD_INTERVAL_MAP[interval_pattern(smallest_chord(chord.pitches))]
      return result + ' triad' if result
      'tone cluster'
    when 2
      interval = chord.pitches.first - chord.pitches.last
      interval = chord.pitches.last - chord.pitches.first if INTERVAL_MAP[interval].nil?
      INTERVAL_MAP[interval]
    when 1
      'unison'
    else
      'tone cluster'
    end
  end

  def self.smallest_chord(pitches)
    pitches_combinations(pitches).min_by { |combination| combination.last - combination.first }
  end

  def self.largest_chord(pitches)
    pitches_combinations(pitches).max_by { |combination| combination.last - combination.first }
  end

  def self.pitches_combinations(pitches)
    combinations = []
    pitches.length.times do |i|
      combination = pitches.map { |pitch| pitch }
      i.times do
        combination[0] = combination[0] + 12
        combination.rotate!
      end
      combinations.push(combination)
    end
    combinations
  end

  def self.interval_pattern(pitches)
    root = pitches.first
    pitches.map { |pitch| pitch - root unless pitch == root }.compact
  end
end
