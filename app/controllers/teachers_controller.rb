# author: Kevin M, Tommy B
# admin methods by Dakota B.
# guards by Meagan Moore
# Teacher methods, as well as admin, super, and home stuff.
class TeachersController < ApplicationController
  
  include TeachersHelper
  
  before_action :is_suspended

  #Before actions to reduce access and prime pages to show teacher info.
  before_action :set_teacher, only: [:show, :edit, :update]
  before_action :same_school, only: [:show, :edit, :update]
  #Guards added by Meagan Moore
  before_action :is_admin, only: [:admin, :admin_report, :index, :new, :create, :login_settings, :show]
  before_action :is_super, only: [:super, :updateFocus, :super_report]



  # GET /teachers
  # This method prepares the index view. It sets up pagination in an ascending
  # order by their screen_name.
  def index
    @current_teacher = current_teacher
    @current_school = School.find(@current_teacher.school_id)
    @teachers = Teacher.where(school_id: @current_teacher.school_id).paginate(page: params[:page], :per_page => 10)
    @teachers = @teachers.order('screen_name ASC')
  end
  
  # GET /admin_report
  #This method prepares the admin_report view.
  def admin_report
    @current_teacher = current_teacher
    @students = Student.where(school_id: current_teacher.school_id).order('full_name ASC')
    @teachers = Teacher.where(school_id: current_teacher.school_id).order('full_name ASC')
    @squares = Square.where(school_id: current_teacher.school_id).order('full_name ASC')
  end
  
  # GET /teachers/1
  # This prepares the roster view for the teacher. It sets up pagination similarly
  # to the teacher index.
  def show
    @teacher = Teacher.find(params[:id])
    @students = @teacher.students.order('full_name ASC')
    @students_at_school = Student.where(school_id: @teacher.school_id).order('full_name ASC')
    @students_not_in_roster = Student.where(school_id: @teacher.school_id).where.not(id: @teacher.students).order('full_name ASC')
    
    #Whenever this page is visited, it updates the roster for the admin.
    if @teacher.powers == "Admin"
      
      #https://stackoverflow.com/questions/3343861/how-do-i-check-to-see-if-my-array-includes-an-object
      @students_at_school.each do |student|
        unless @students.include?(student)
          @teacher.students << Student.find(student.id)
        end
      end
    
      @students = @students_at_school
      @students_not_in_roster = []
    end
    
    #Admins always have every student, so they can't add or remove from any admins.
    if params[:add_student]
        if params[:add_student_id] != nil
          if @teacher.powers != "Admin"
            @teacher.students << Student.find(params[:add_student_id])
          end
        end
        
    elsif params[:remove_student]
      if params[:remove_student_id] != nil
        if @teacher.powers != "Admin"
          @teacher.students.delete(Student.find(params[:remove_student_id]))
        end
      end
    end
  end
  
  # GET /teachers/id/login_settings
  def login_settings
    @teacher = Teacher.find(params[:id])
  end

  # GET /teachers/new
  # This prepares the new teacher form.
  def new
    @teacher = Teacher.new
  end

  # GET /teachers/1/edit
  # If the user viewing a profile isn't an admin, then it shows them their own
  # profile instead.
  def edit
    if !is_admin?
      @teacher = @current_teacher
      params[:id] = @teacher.id
    end
  end
  
  # GET /admin
  # This prepares the admin dashboard.
  def admin
    @teacher = current_teacher
    @current_school = School.find(current_teacher.school_id)
  end 
  
  # GET /teachers/password
  # This prepares the password change page. It will always show the current user's,
  # even if they try to access it with another ID via /teachers/id/edit_password.
  # Used http://stackoverflow.com/questions/25490308/ruby-on-rails-two-different-edit-pages-and-forms-how-to for help
  def edit_password
    @teacher = current_teacher
    params[:id] = @teacher.id
  end

  # POST /teachers
  # This creates a new Teacher. It's basically just scaffolding, but the redirect
  # has been changed.
  def create
    @teacher = Teacher.new(teacher_params)

    respond_to do |format|
      if @teacher.save
        format.html { redirect_to teachers_path, :flash => { :notice => "Teacher was successfully created." } }
      else
        format.html { render :new }
      end
    end
  end

  #author: Matthew O & Alex P
  #home page for teachers, display top 8 most used students, route to anaylze or new session
  def home
    @teacher = current_teacher
    @top_students = Student.where(id: Session.where(session_teacher: @teacher.id).group('session_student').order('count(*)').select('session_student').limit(8))
    if params[:start_session]
        @student = Student.find(params[:student_id])
        if(@student.squares.size == 0)
          respond_to do |format|
            format.html { redirect_to home_path, :flash => { :notice => 'Cannot start session with student who has no behaviors to track' } }
          end
        else
          @session = Session.new
          @session.session_teacher = @teacher.id
          @session.session_student = params[:student_id]
          respond_to do |format|
            if @session.save
              format.html { redirect_to @session, :flash => { :notice => 'Session was successfully created.' } }
            else
              format.html { render :new }
            end
          end
        end
    elsif params[:analyze]
        redirect_to analysis_student_path(params[:student_id])
    end
  end
  
  
  # PATCH/PUT /teachers/1
  # This updates a teacher. If current_password is in the params, then they're
  # trying to change their password, so it redirects the put to change_password.
  #
  # Similarly, if suspended is in the params, then it changes their success or
  # error redirection.
  def update      
    if params[:teacher][:current_password]
      change_password
    elsif params[:teacher][:suspended]
      change_login_settings
    else
      respond_to do |format|
        if @teacher.update(teacher_params)
          format.html { redirect_to edit_teacher_path(@teacher.id), :flash => { :notice => 'Teacher was successfully updated.' } }
        else
          format.html { render :edit }
        end
      end
    end
  end
  
  # This method displays flashes for updates to login settings. It's virtually
  # identical to update, but it redirects to a different location with a different
  # flash.
  def change_login_settings
    respond_to do |format|
      if @teacher.update(teacher_params)
        format.html { redirect_to edit_teacher_path(@teacher.id), :flash => { :notice => 'Login settings for this teacher were successully updated.' } }
      else
        format.html { render :login_settings }
      end
    end
  end
  
  # This method changes the Teacher's password and displays appropriate flashes.
  # Used http://stackoverflow.com/questions/25490308/ruby-on-rails-two-different-edit-pages-and-forms-how-to for help
  # for method layout.
  def change_password
    teacher = current_teacher
    if teacher.authenticate(params[:teacher][:current_password])
      if params[:teacher][:password] == params[:teacher][:password_confirmation]
        teacher.password = params[:teacher][:password]
        if teacher.save!
          redirect_to edit_teacher_path(teacher), :flash => { :notice => "Password changed." }
        end
      else
        redirect_to edit_password_teacher_path, :flash => { :error => "New password and confirmation didn't match." }
      end
    else
      redirect_to edit_password_teacher_path, :flash => { :error => "Incorrect password." }
    end
  end
   
  # This method prepares the super view.
  def super 
    @schools = School.all
   # @school = School.first
    @teacher = Teacher.find(params[:id])
  end
  


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end
    
    def set_school
      @school = School.find(current_teacher.school_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def teacher_params
      params.require(:teacher).permit(:user_name, :last_login,
      :full_name, :screen_name, :icon, :color, :email, :description, :powers, 
      :school_id, :password, :password_confirmation, :suspended, :current_password, :hiddenVal) #add hidden field to permited
    end
    
    #Can only access teachers and info from the same school
    def same_school
      if current_teacher.school_id != Teacher.find(params[:id]).school_id
        redirect_to home_path, :flash => { :notice => "You can't access other schools." }
      end
    end
    
    # Switching the focus school 

  # def focus_school_params 
  #  params.permit(:full_name)
  # end 
end
