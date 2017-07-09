# Author: Debra Jensen
# Helpers related to UX colors and CSS 
module UxHelper
  
  # top 10 colors
  def allColors
    [ "aqua", "black", "blue", "gray", "green", 
        "orange", "pink", "purple", "red", "yellow" ]
  end

  def schoolColors
    allColors
  end

  def studentColors
    [ "aqua", "black", "blue", "gray", "red", "yellow"]
  end

  def teacherColors
    [ "aqua", "black", "blue", "gray", "pink"]
  end

  def squareColors
    allColors
  end

  # student icon string names for selections, same as the fa CSS class names
  def studentIcons
    ["bug", "car", "puzzle-piece", "flash", "futbol-o", "gamepad",
              "heart", "leaf","paper-plane","paw","star", "graduation-cap"]
  end

  # teacher icon string names for selections, same as the fa CSS class names
  def teacherIcons
    ["apple", "book", "pencil", "calculator"]
  end

  # school icon string names for selections, same as the fa CSS class names
  def schoolIcons
    ["home", "building-o", "university"]
  end


  # returns correct CSS home icon tag for a student's color
  def home_icon_color( student)
    "home-icon-" << student.color
  end

  # color string names for selections
  # BILL - should these be per object: schools, teachers, etc?
  # def colorNames
  #   ["red", "orange", "yellow", "green", "mint", "navy", "lightblue", 
  #         "lavender", "plum", "pink"]
  # end

end
