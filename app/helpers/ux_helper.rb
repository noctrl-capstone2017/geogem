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
    ["bug", "car", "puzzle-piece", "flash", "futbol-o", "gamepad",
              "heart", "leaf","paper-plane","paw","star", "graduation-cap"]
  end

  # teacher icon name choices
  def teacherIcons
    ["apple", "book", "pencil", "calculator"]
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

end
