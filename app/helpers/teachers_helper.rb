# Authors: Steven R, Kevin M
# Mostly contains methods for checking permissions
module TeachersHelper

  # Returns true if current teacher has Admin powers
  def is_admin?
    current_teacher && current_teacher.powers == "Admin"
  end

  # Returns true if current teacher has Admin powers
  # If not Admin, then flash error and redirect to home
  def is_admin
    if !is_admin?
      flash[:danger] = "Unauthorized. You are not an administrator"
      redirect_to home_path
    end
  end

  # Returns true if current teacher is Super User
  def is_super?
    current_teacher && current_teacher.id == 1
  end

  # Returns true if current teacher is Super User
  # If not Super, then flash error and redirect to home
  def is_super
    if !is_super?
      flash[:danger] = "Unauthorized. You are not a super user."
      redirect_to home_path
    end
  end
    
  # Returns true if current teacher is suspended 
  def is_suspended?
    current_teacher && current_teacher.suspended == true
  end

  # Returns true if current teacher is suspended
  # If IS suspended, then flash error and redirect to root
  def is_suspended
    if is_suspended?
      flash[:danger] = "Your account has been suspended."
      redirect_to root_path
    end
  end

  # Returns the Super User/Teacher, the first teacher in the table 
  def super_teacher
    Teacher.first
  end

  # Returns a "smart" home message based on whether it's the teachers 
  # first ever login or first time visiting Home page or neither
  def home_welcome_message( teacher, first_login, first_home)
    if first_login
      tmp = "Welcome to Geogem, " 
    elsif first_home
      tmp= "Welcome back, "
    else
      tmp = "home page, "
    end
    tmp << teacher.full_name
  end
end
