module SquaresHelper

  # return ux string for the behavio
  def ux_square_tracking_type( square)
    case square.tracking_type
    when 1 
      "Duration"
    when 2
      "Frequency"
    when 3
      "Interval"
    else
      "Unknown"
    end
  end

end
