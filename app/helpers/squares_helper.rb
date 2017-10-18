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

  def square_type_acroynm( square)
    case square.tracking_type
    when 1
      "Dur"
    when 2
      "Freq"
    when 3
      "Int"
    else
      "Unknown"
    end
  end
end
