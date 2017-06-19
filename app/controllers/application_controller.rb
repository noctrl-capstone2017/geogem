# Application Controller
# Confirms that the teacher is logged in
# Author: Meagan Moore & Steven Royster

class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  include LoginSessionHelper

  # All pages require login; special pages use skip_before_action to avoid this
  before_action :require_login

  # special pages (like login, about) handle their own navbar and layout. Source:
  # https://stackoverflow.com/questions/13395153/how-to-render-partial-on-everything-except-a-certain-action
  def special_navbar_and_layout
    @special_navbar_and_layout = true
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

    # Guard each page, checks for logged in
    def require_login  
      unless current_teacher
      flash[:danger] = "Log in is not current"
        redirect_to login_url
      end
    end

end
