#Written by Debra Jensen
module UxHelper
  #Returns array of student icon string names for selections, these are the same as the fa class names
  def studentIcons
    icons = ["bug", "car", "puzzle-piece", "flash", "futbol-o", "gamepad","heart", "leaf","paper-plane","paw","star","graduation-cap"];
    return icons;
  end
  
  #Returns array of teacher icon string names for selections, these are the same as the fa class names
  def teacherIcons
    icons = ["apple", "book", "pencil", "calculator"];
    return icons;
  end
  
  #Returns array of color string names for selections
  def colorNames
    colors = ["red", "orange", "yellow", "green", "mint", "navy", "light blue", "lavender", "plum", "pink"]; 
    return colors;
  end
  
  #Returns string of the color hexes, in the same order as above
  #It's preferable to just use the css rules for color
  def colorHex
    hex = ["#EC514A", "#F8BD28", "#FFEB65", "#8BC04F", "#5BC2A8", "#2458B7", "#97EDEC", "#8E7BB9", "#B23F73", "#E889B9"];
    return hex;
  end
end