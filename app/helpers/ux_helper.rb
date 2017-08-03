# Author: Debra Jensen
# Helpers related to UX colors and CSS 
module UxHelper
  
  # color palette is top 10 colors at www.thetoptens.com/top-ten-favorite-colors
  def allColors
    [ "aqua", "black", "blue", "gray", "green", 
        "orange", "pink", "purple", "red", "yellow" ]
  end

  # schools color palette
  def schoolColors
    allColors
  end

  # students color palette
  def studentColors
    allColors
  end

  # teachers color palette
  def teacherColors
    allColors
  end

  # squares color palette
  def squareColors
    allColors
  end

  # all icon names below MUST match Font Awesome icons: fa-<icon_name>

  # student icon name choices
  def studentIcons
    ["bug", "car", "flash", "futbol-o", "gamepad", "graduation-cap", 
          "heart", "leaf", "paper-plane", "paw", "puzzle-piece", "star"]
  end

  # teacher icon name choices
  def teacherIcons
    icons = ["apple", "book", "calculator", "pencil"]
    if is_super?
      icons << "hand-peace-o"     # super only - peace and victory
    end
    icons
  end

  # school icon name choices
  def schoolIcons
    ["home", "building-o", "university"]
  end

  # returns icon color CSS for object, as defined in general.css
  def icon_color( object)
    "i-" << object.color
  end

  # returns glow color CSS for object, as defined in general.css
  def glow_color( object)
    return "glow-" << object.color
  end

  # returns Font Awesome css for icon
  def fa_icon( object)
    "fa-" << object.icon
  end

  def fa_bsquare_icon( square)
    if square.tracking_type == 1
      "fa-clock-o"
    else
      ""
    end
  end

  # returns correct CSS home icon tag for a student, as defined in general.css
  def home_icon_color( student)
    "home-icon-" << student.color
  end

  # These are WEIRD methods used to control row code in views
  # I decided to do this when I couldn't find % (modulo) in Rails view

  # returns true if index is on the first row (value=0) 
  def ux_first_row(index)
    (index == 0)
  end

  # returns true if index is t
  def ux_last_row( index, num_rows)
    (index == num_rows-1)
  end

  # returns true if index is the beginning of a new row
  def ux_next_row( index, row_size)
    (index != 0)  &&  (index % row_size == 0)
  end

end
