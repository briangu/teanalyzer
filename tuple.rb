require 'rubygems'
require 'teanalyzer'

class Tuple 
  def alternating_hand?
    keys_hand { |h1, h2| h1!=h2 }
  end

  def same_hand?
    keys_hand { |h1, h2| h1==h2 }
  end

  def keys selector
    [selector.call(@keys[0]), selector.call(@keys[1])]
  end

  def keys_key &block
    keys_accessor(lambda { |k| k }, &block)
  end

  def keys_row_idx &block
    keys_accessor(lambda { |k| k.row_idx }, &block)
  end

  def keys_hand &block
    keys_accessor(lambda { |k| k.hand }, &block)
  end

  def keys_distance &block
    keys_accessor(lambda { |k| k.distance }, &block)
  end

  def keys_penalty &block
    keys_accessor(lambda { |k| k.penalty }, &block)
  end

  def keys_accessor(accessor, &block)
    t = keys(accessor)
    block.call(t[0], t[1])
  end

  #fingers
  def all_fingers_same(k1, k2)
    k1.finger_idx == k2.finger_idx
  end

  def all_fingers_different(k1, k2)
    k1.finger_idx != k2.finger_idx
  end

  def some_fingers_different(k1, k2)
    fingers = [k1.finger_idx, k2.finger_idx].sort
    a = fingers[0]
    b = fingers[1]
    (a != b)
  end

  def fingers_progress_right(k1, k2)
    (k1.finger_idx <= k2.finger_idx)
  end

  def fingers_progress_left(k1, k2)
    (k1.finger_idx >= k2.finger_idx)
  end

  def monotonic_progression(k1, k2)
    fingers_progress_right(k1, k2) || fingers_progress_left(k1, k2)
  end

  def finger_rolling_right(k1, k2)
    k1.finger_idx < k2.finger_idx
  end

  def finger_rolling_left(k1, k2)
    k1.finger_idx > k2.finger_idx
  end

  def finger_rolling(k1, k2)
    finger_rolling_left(k1, k2) || finger_rolling_right(k1, k2)
  end

  def middle_left_right(k1, k2)
    # e.g: nep
    k2.finger_idx < k1.finger_idx
  end

  def middle_right_left(k1, k2)
    # e.g: dhx
    k1.finger_idx < k2.finger_idx
  end

  def not_monotonic(k1, k2)
    middle_left_right(k1, k2) || middle_right_left(k1, k2)
  end

  def not_monotonic_progression(k1, k2)
    k1.finger_idx != k2.finger_idx
  end

  #keys
  def no_key_repeats(k1, k2)
    k1 != k2
  end

  def some_keys_repeat(k1, k2)
    k1 == k2
  end

  def all_keys_different(k1, k2)
    k1 != k2
  end

  public
  OVERLAP = 2

  def initialize(char1, char2)
    @char1 = char1
    @char2 = char2
    @keys = [Keyboard.get_key_for(@char1), Keyboard.get_key_for(@char2)]
  end

  def valid?
    @keys[0] != nil && @keys[1] != nil
  end

  def text
    @char1 + @char2
  end

  def hand_effort
    if alternating_hand?
      1
    elsif same_hand?
      2
    else
      0
    end
  end


  def cant_determine_effort(effort_type, i1, i2)
    raise ArgumentError, "can't determine #{effort_type} for combination (#{i1},#{i2})"
  end

  def row_effort
    if keys_row_idx { |i1, i2| (i1 != i2) && [(i1-i2)].min < -1 }
      # some different, not monotonic, max row change upward > 1
      7
    elsif keys_row_idx { |i1, i2| i1 < i2 }
      # upward progression
      6
    elsif keys_row_idx { |i1, i2| (i1 != i2) && [(i1-i2)].max > 1 }
      # some different, not monotonic, max row change downward > 1
      5
    elsif  keys_row_idx { |i1, i2| i1 > i2 }
      # downward progression
      4
    elsif keys_row_idx { |i1, i2| i1 == i2 || i1 < i2 }
      # upward progression, with repetition
      2
    elsif keys_row_idx { |i1, i2| i1 == i2 || i1 > i2 }
      # downward progression, with repetition
      1
    elsif keys_row_idx { |i1, i2| i1 == i2 }
      #same
      0
    else
      keys_row_idx { |i1, i2| cant_determine_effort('row_effort', i1, i2) }
    end
  end

  def finger_effort
    if keys_key { |k1, k2| all_fingers_same(k1, k2) && all_keys_different(k1, k2) }
      # same, no key repeat
      7
    elsif keys_key { |k1, k2| some_fingers_different(k1, k2) && no_key_repeats(k1, k2) && monotonic_progression(k1, k2) }
      # some different, no key repeat, monotonic progression
      6
    elsif keys_key { |k1, k2| all_fingers_same(k1, k2) }
      # same, key repeat
      5
    elsif keys_key { |k1, k2| some_fingers_different(k1, k2) && not_monotonic_progression(k1, k2) }
      # some different, not monotonic progression'
      4
    elsif keys_key { |k1, k2| all_fingers_different(k1, k2) && not_monotonic(k1, k2) }
      # all different, not monotonic
      3
    elsif keys_key { |k1, k2| finger_rolling(k1, k2) }
      # rolling
      2
    elsif keys_key { |k1, k2| some_fingers_different(k1, k2) && some_keys_repeat(k1, k2) && monotonic_progression(k1, k2) }
      # some different, key repeat, monotonic progression
      1
    elsif keys_key { |k1, k2| all_fingers_different(k1, k2) && (monotonic_progression(k1, k2)) }
      # all different, monotonic progression
      0
    else
      keys_key { |k1, k2| cant_determine_effort('finger_effort', k1.chars, k2.chars) }
    end
  end

  def base_effort
    p = Parameters.instance
    keys_distance { |d1, d2| p.key_1_weight*d1*(1+p.key_2_weight*d2) }
  end

  def penalty_effort
    p = Parameters.instance
    keys_penalty { |d1, d2| p.key_1_weight*d1*(1+p.key_2_weight*d2) }
  end

  def path_effort
    p = Parameters.instance
    (hand_effort * p.hands_stroke_path_weight +
        row_effort * p.rows_stroke_path_weight +
        finger_effort * p.rows_finger_path_weight)
  end

  def effort
    p = Parameters.instance
    p.base_effort_weight*base_effort + p.penalty_effort_weight*penalty_effort + p.stroke_path_effort_weight*path_effort

  end

  def ==(another)
    if another == nil
      false
    else
      self.text == another.text
    end
  end

  def self.from_text(word)
    if word == nil
      return []
    end
    word = word.gsub(/\s/,'')
    first = word.chars
    second = first.drop(1)
    triads = first.zip(second.zip).
        select { |e| e[0] != nil && e[1] != nil && e[1][0] != nil }.
        map { |e| Tuple.new(e[0], e[1][0]) }
    triads.select { |t| t.valid? }
  end
end
