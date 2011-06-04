require File.expand_path('./../hands_parameters', __FILE__)
require File.expand_path('./../rows_parameters', __FILE__)

class Parameters
  attr_accessor :default_penalty, :hands, :rows, :hands_penalty_weight, :rows_penalty_weight, :fingers_penalty_weight 

  def initialize
    @default_penalty = 0.0
    @hands = HandsParameters.new
    @rows  = RowsParameters.new
    # penalty weights
    @hands_penalty_weight = 0.0
    @rows_penalty_weight = 1.0
    @fingers_penalty_weight = 2.0
       
    # row penalty
    @rows.row_1_penalty_bottom = 1.0
    @rows.row_2_penalty_home = 0.0
    @rows.row_3_penalty = 0.0
    @rows.row_4_penalty_top = 0.0
    
    # hand penalty
    @hands.left.penalty = 1.0
    @hands.right.penalty = 1.0
        
    # finger penalty
    @hands.left.finger_0_penalty = 2.0
    @hands.left.finger_1_penalty = 1.0
    @hands.left.finger_2_penalty = 0.0
    @hands.left.finger_3_penalty = 0.0
    @hands.left.finger_4_penalty = 0.0
    
    @hands.right.finger_5_penalty = 2.0
    @hands.right.finger_6_penalty = 1.0
    @hands.right.finger_7_penalty = 0.0
    @hands.right.finger_8_penalty = 0.0
    @hands.right.finger_9_penalty = 0.0
      
  end
end