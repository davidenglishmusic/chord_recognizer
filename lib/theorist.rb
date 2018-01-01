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

  def self.pitch_to_number(pitch)
    PITCH_NUMBER_MAP[pitch]
  end
end
