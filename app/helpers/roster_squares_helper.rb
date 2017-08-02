module RosterSquaresHelper

  # get the real behavior square associated with a roster square
  def get_real_square( roster_square)
    Square.find( roster_square.square_id)
  end
end
