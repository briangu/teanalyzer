require File.expand_path('./../../app/key', __FILE__)
require File.expand_path('./../../app/parameters', __FILE__)

describe 'Key' do
  before(:each) {
    @p = Parameters.new
    # configure the parameter in order to test the calculation as easy as possible
    @p.default_penalty = 7.0
    @p.rows_penalty_weight = 0.5
    @p.hands_penalty_weight = 1.3
    @p.fingers_penalty_weight = 2.3
    # row penalty
    @p.rows.row_1_penalty_bottom = 3.0
    @p.rows.row_2_penalty_home = 1.0
    @p.rows.row_3_penalty = 2.0
    @p.rows.row_4_penalty_top = 2.5
    # hand penalty
    @p.hands.left.penalty = 2.2
    @p.hands.right.penalty = 1.7
    # finger penalty
    @p.hands.left.finger_0_penalty = 1.5
    @p.hands.left.finger_1_penalty = 1.4
    @p.hands.left.finger_2_penalty = 1.3
    @p.hands.left.finger_3_penalty = 1.2
    @p.hands.left.finger_4_penalty = 1.1
    @p.hands.right.finger_5_penalty = 1.6
    @p.hands.right.finger_6_penalty = 1.7
    @p.hands.right.finger_7_penalty = 1.8
    @p.hands.right.finger_8_penalty = 1.9
    @p.hands.right.finger_9_penalty = 2.0
  }
  context 'bB' do
    subject { Key.new 'bB', 1.0, :left, :first_row, :finger_3, @p }
    describe 'penalty' do
      it 'should be correct' do
        subject.penalty.should be==(14.12)
      end
    end
    describe '==' do
      it '#Bb should be ==' do
        (subject == Key.new('Bb', 1.0, :left, :first_row, :finger_3, @p)).should be(true)
      end
      it '#g should not be == ' do
        (subject == Key.new('g', 2.0, :left, :first_row, :finger_3, @p)).should be(false)
      end
      it '#nil should not be == ' do
        (subject == nil).should be(false)
      end
    end
    describe 'distance' do
      it 'should be 1.0' do
        subject.distance.should ==(1.0)
      end
    end
  end
end