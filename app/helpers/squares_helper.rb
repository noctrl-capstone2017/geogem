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
      "Unknown=" + "" + square.tracking_type.to_s
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
      "Unknown=" + "" + square.tracking_type.to_s
    end
  end
end
