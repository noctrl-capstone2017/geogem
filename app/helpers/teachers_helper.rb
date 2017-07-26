# Authors: Steven R, Kevin M
# Mostly contains methods for checking permissions
module TeachersHelper

  # Returns true if current teacher is an Admin
  def is_admin?
    current_teacher && current_teacher.admin
  end

  # Returns true if current teacher is an Admin
  # If not Admin, then flash error and redirect to home
  def is_admin
    if !is_admin?
      flash[:danger] = "Unauthorized. You are not an admin"
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
  def home_welcome_message( teacher, first_home)
    if first_home
      if teacher.last_login == nil
        "Welcome to Geogem, " << teacher.full_name
      else 
         # construct a nice string for last login: earlier today, yesterday, or a specific date
        login_date = teacher.last_login.to_date
        if login_date == Date.today
          tmp = "earlier today"
        elsif login_date == Date.yesterday
          tmp = "yesterday"
        else
          tmp = teacher.last_login.strftime('%A %B %d')
        end
        "Welcome back, " << teacher.full_name << "... your last login was " << tmp << "."
      end
    else
      "home page, " << teacher.full_name
    end
  end

  # show teacher powers (admin of not) in a view, nicely
  def show_powers(teacher, just_teacher_text = "")
    if teacher == super_teacher
      "Super!"
    elsif teacher.admin
      "Admin"
    else
      just_teacher_text
    end
  end
end
