# Authors: Meagan Moore & Steven Royster
module LoginSessionHelper

  # Logs in the given teacher.
  def log_in(teacher)
    session[:teacher_id] = teacher.id
  end

  # Returns the current logged-in teacher (if any).
  def current_teacher
    if (teacher_id = session[:teacher_id])
      @current_teacher ||= Teacher.find_by(id: teacher_id)
    end
  end
  
  # Returns true if the teacher is logged in, false otherwise.
  def logged_in?
    !current_teacher.nil?
  end
  
  # Returns true if the teacher is logged out, false otherwise.
  def logged_out?
    current_teacher.nil?
  end
  
  # Redirects the teacher to the login page if they are not logged in.
  def logged_in
    if !logged_in?
      flash[:danger] = "You are not logged in"
      redirect_to login_url
    end
  end
  
  # Logs out the current teacher.
  def log_out
    session.delete(:teacher_id)
    @current_teacher = nil
  end
  
end