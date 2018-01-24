module SquaresHelper

  # return ux string for the behavior square
  def ux_square_tracking_type( square)
    case square.tracking_type
    when 1 
      "Counter"
    when 2
      "Timer"
    else
      "Unknown=" + "" + square.tracking_type.to_s
    end
  end

end
