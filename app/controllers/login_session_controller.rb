# Login Session Controller
# Finish log in & log out
# Author: Meagan Moore & Steven Royster

class LoginSessionController < ApplicationController

  include LoginSessionHelper

  # The teacher can only log out if they are actually logged in
  before_action :logged_in, only: [:logout]
  
    
  # Skips guard require login because these are login pages
  skip_before_action :require_login
  
  # login page
  def new
    #Edit by Kevin M:
    #redirects to home page if already logged in
    #Steven Royster: added the '&& && !current_teacher.suspended == true'
    if current_teacher && !current_teacher.suspended == true
      redirect_to home_path
    end
  end
  
  # logs in the teacher if successful, flashes a danger if invalid log in info
  def create
    teacher = Teacher.find_by(:user_name => params[:login_session][:user_name].downcase)
    if teacher && teacher.authenticate(params[:login_session][:password]) && !teacher.suspended == true
      log_in teacher
      teacher.update_attribute(:last_login, Time.now)
     # params[:login_session][:remember_me] == '1' ? remember(teacher) : forget(teacher)
      redirect_to home_path
      
    else
      if teacher && teacher.suspended == true
        flash.now[:danger] = 'Your account has been suspended'
        render 'new'
      else
        flash.now[:danger] = 'Invalid username/password combination'
        render 'new'
      end
    end
    
  end

  # logout page
  def logout
      log_out if logged_in?
  end

end
