# Authors: Meagan Moore & Steven Royster
class LoginSessionController < ApplicationController

  include LoginSessionHelper
  include TeachersHelper

  # login and logout are special pages that handle their own navbar and layout 
  before_action :special_navbar_and_layout

  # skip login guard; these pages don't require login
  skip_before_action :require_login

  # login page
  def new
    if current_teacher && !current_teacher.suspended
      redirect_to home_path
    end
  end
  
  # logs in the teacher if successful, flashes a danger if invalid log in info
  def create
    teacher = Teacher.find_by(:user_name => params[:login_session][:user_name].downcase)
    if teacher && teacher.authenticate(params[:login_session][:password]) && !teacher.suspended
      log_in teacher
      first_ever_login =  ! teacher.last_login
      teacher.update_attribute(:last_login, Time.now)
      if first_ever_login
        redirect_to home_path( :first_login => true)
      else
        redirect_to home_path( :first_home => true)
      end
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
    # reset super focus school to Noctrl
    current_teacher.update_attribute(:school_id, 1) if is_super?
    log_out if logged_in?
  end

end
