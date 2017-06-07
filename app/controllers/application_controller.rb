# Application Controller
# Confirms that the teacher is logged in
# Author: Meagan Moore & Steven Royster

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include LoginSessionHelper
  # Checks to make sure user is logged in before 
  # accessing most of the web application's pages
  before_action :require_login

  #Author: Matthew O & Alex P
  #allow disabling of showing the navbar on certain screens
  #https://stackoverflow.com/questions/13395153/how-to-render-partial-on-everything-except-a-certain-action
  def disable_nav
    @disable_nav = true
  end

  private
    # Confirms a logged-in user.
    def logged_in_teacher  
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
  private
    # Guard each page, checks for logged in
    def require_login  
      unless current_teacher
      flash[:danger] = "Log in is not current"
        redirect_to login_url
      end
    end
    
end