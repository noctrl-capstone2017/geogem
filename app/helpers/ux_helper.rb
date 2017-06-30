# Author: Debra Jensen
module UxHelper
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

  # color string names for selections
  # BILL - should these be per object: schools, teachers, etc?
  def colorNames
    ["red", "orange", "yellow", "green", "mint", "navy", "ltblue", 
          "lavender", "plum", "pink"]
  end

end
