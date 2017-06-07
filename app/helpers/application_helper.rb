# Application Helper
# Fills an array with all student art, gets a random image
# Author: Meagan Moore & Steven Royster


module ApplicationHelper
  
  # Returns random artwork path
  def random_student_art
    # fill array with all student art
    images = Dir.glob("app/assets/images/student_art/*.jpg").to_a
    # get a random image from array
    images[rand(images.size)]
  end

end
