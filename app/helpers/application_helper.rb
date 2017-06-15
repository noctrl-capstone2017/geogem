# Author: Meagan Moore & Steven Royster

module ApplicationHelper
  
  # Returns the full title on a per-page basis.
  # Source: https://github.com/noctrl-csc694-fall2016/giftgarden
  def full_title(page_title = '')
    base_title = "GeoGem"
    if page_title.empty?
      base_title
    else
      page_title + " ◆ " + base_title
    end
  end

  # Returns random artwork path
  def random_student_art
    # fill array with all student art, return one at random
    images = Dir.glob("app/assets/images/student_art/*.jpg").to_a
    images[rand(images.size)]
  end

end
