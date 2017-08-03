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

  # Returns a "fancy" home message based on whether it's the teachers 
  # first ever login or first time visiting Home page or neither
  def ux_fancy_home_welcome( teacher, first_home)
    if first_home
      if teacher.last_login == nil
        msg = "Welcome to Geogem, " << teacher.full_name
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
        msg = "Welcome back, " << teacher.full_name << "... your last login was " << tmp
      end
    else
      msg = "home page, " << teacher.full_name
    end
    msg << ". Select a student you'd like to work with."
  end

  # return ux string for teacher name
  def ux_teacher_name( teacher, num_chars=20)
    num_chars > 0 ? teacher.full_name.truncate( num_chars) : teacher.full_name
  end

  # return ux string for teacher powers (admin of not)
  def ux_teacher_powers(teacher, just_teacher_text = "")
    if teacher == super_teacher
      "Super!"
    elsif teacher.admin
      "Admin"
    else
      just_teacher_text
    end
  end

  # return ux string for the teacher's last login date  
  def ux_teacher_last_login( teacher)
    str = teacher.last_login ? time_ago_in_words( teacher.last_login) : "Never"
    if teacher.suspended?
      str = str << " (suspended)"
    end
    str
  end

end
