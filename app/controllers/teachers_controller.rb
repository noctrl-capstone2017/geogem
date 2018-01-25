# authors: Kevin M, Tommy B; admin methods by Dakota B; guards by Meagan Moore
class TeachersController < ApplicationController
  include TeachersHelper
  include UxHelper

  before_action :is_suspended
  before_action :set_teacher, only: [:show, :edit, :update]
  before_action :same_school, only: [:show, :edit, :update]
  before_action :is_admin, only: [:edit, :update, :admin, :admin_report, :index, :new, :create, :login_settings]
  before_action :is_super, only: [:super, :update_super_focus, :super_report]

  # GET /teachers
  # Show all teachers. Sets up pagination in an ascending order by their screen_name.
  def index
    @current_teacher = current_teacher
    @school = School.find(@current_teacher.school_id)
    @teachers = Teacher.where(school_id: @current_teacher.school_id).paginate(page: params[:page], :per_page => 10)
    @teachers = @teachers.order('LOWER(full_name) ASC')
  end

  # GET /teachers/new
  # This prepares the new teacher form.
  def new
    @current_teacher = current_teacher
    @school = School.find(@current_teacher.school_id)
    @teacher = Teacher.new
    @teacher.color = teacherColors.first
    @teacher.icon = teacherIcons.first
  end

  # POST /teachers/new
  # Creates a new Teacher. Just scaffolding, but the redirect has been changed.
  def create
    @teacher = Teacher.new(teacher_params)
    @school = School.find(@teacher.school_id)

    if @teacher.save
      flash[ :success] = "Teacher #{ @teacher.full_name } was successfully created."
      redirect_to teachers_path
    else
      render :new
    end
  end

  # GET /teachers/1/edit
  # admin page 1 - edit teacher profile
  def edit
    @teacher = Teacher.find(params[:id])
  end

  # GET /teachers/id/edit2
  # admin page 2 - change login settings
  def edit2
    @teacher = Teacher.find(params[:id])
  end

  # GET /teachers/id/edit3
  # admin page 3 - define teacher access to student analysis
  def edit3
    @teacher = Teacher.find(params[:id])
    @students = @teacher.students.order('full_name ASC')
    @students_at_school = Student.where(school_id: @teacher.school_id).order('full_name ASC')
    @students_not_in_roster = Student.where(school_id: @teacher.school_id).where.not(id: @teacher.students).order('full_name ASC')
  end

  # POST /teachers/1
  # Admin updates a teacher here for all 3 edit pages.
  # Attributes in params[] are used to mux the updating to the correct methods
  def update
    if params[:edit1]
      update1_profile
    elsif params[:edit2a]
      update2_login_settings
    elsif params[:edit2b]
      update2_password
    elsif params[:edit3_add]  ||  params[:edit3_remove]  ||  params[:edit3_access]
      update3_access
    else
      redirect_to home_path
    end
  end

  # update admin page 1 - teacher profile attributes 
  def update1_profile
    if @teacher.update(edit_profile_params)
      flash[ :success] = "Profile update successful"
      redirect_to edit_teacher_path(@teacher)
    else
      render 'edit'
    end
  end

  # update admin page 2a - teacher login settings (suspended flag)
  def update2_login_settings
    if @teacher.update(edit_login_settings_params)
      flash[ :success] = "Login status change successful"
      redirect_to edit2_teacher_path(@teacher)
    else
      render 'edit2'
    end
  end

  # update admin page 2b - change teacher password 
  def update2_password
    if @teacher.update(edit_password_params)
      flash[ :success] = "Password change successful"
      redirect_to edit2_teacher_path(@teacher)
    else
      render 'edit2'
    end
  end

  # update admin page 3 - change teacher access to students, aka the roster
  def update3_access
    # add student to roster
    if params[:edit3_add]  &&  (params[:add_student_id] != nil)
      @teacher.students << Student.find(params[:add_student_id])
      redirect_to edit3_teacher_path(@teacher)

    # remove student from roster
    elsif params[:edit3_remove]  &&  (params[:remove_student_id] != nil)
      @teacher.students.delete(Student.find(params[:remove_student_id]))
      redirect_to edit3_teacher_path(@teacher)

    elsif params[:edit3_access]
      @teacher.update(access_params)
      # NOTE - I though about this one. A toughie.
      # If access_all_students, then delete all students in the roster?
      # I decided against it and just leave the roster alone. It's hidden and 
      # unused in all pages if access_all_students is true.
      redirect_to edit3_teacher_path(@teacher)
    end

  end

  # GET /profile
  # show profile of the current teacher
  def profile
    @teacher = current_teacher
    params[:id] = @teacher.id
  end

  # GET /properties
  # show profile of the current teacher
  def properties
    @teacher = current_teacher
    params[:id] = @teacher.id
  end

  # PATCH /properties
  # edit current teacher's properties
  def update_properties
    @teacher = current_teacher
    if @teacher.update(teacher_params)
      flash[ :success] = "Properties update successful"
      redirect_to profile_path
    else
      render :properties
    end
  end

  # GET /password
  # show page for current teacher to change his/her password
  # Source: stackoverflow.com/questions/25490308/ruby-on-rails-two-different-edit-pages-and-forms-how-to for help
  def password
    @teacher = current_teacher
  end

  # PATCH /password
  # change current teacher's password
  def update_password
    @teacher = current_teacher

    # case 1 - verify current password
    my_params = password_params
    if (! @teacher.authenticate( my_params[:current_password]))
      flash[:danger] = "Incorrect password entered"
      redirect_to password_path

    # case 2 - new password and confirmation must match
    elsif my_params[:password] != my_params[:password_confirmation]
      flash[:danger] = "New password and confirmation don't match"
      redirect_to password_path

    # case 3 - update new password, error if this fails
    else
      @teacher.password = my_params[:password]
      if @teacher.save
        flash[ :success] = "Password change successful"
        redirect_to profile_path
      else
        render 'password'     # saving new password failed
      end
    end
  end

  #author: Matthew O & Alex P
  #home page for teachers, display top 8 most used students, route to anaylze or new session
  def home
    @teacher = current_teacher
    @first_login = params[:first_login] != nil
    @first_home = params[:first_home] != nil
    @view_all = params[:view_all] != nil
    @top_students = Student.where(id: Session.where(session_teacher: @teacher.id).group('session_student').order('count(*)').select('session_student').limit(8))
    @all_students = Student.where(school_id: current_teacher.school_id)
  end

  # PATCH /home
  # Update home means goto the select Student page and get some work done
  def update_home
    @teacher = current_teacher
    if params[:go_student]
      @student = Student.find( params[:student_id])
      redirect_to @student
    else
      redirect_to home_path
    end
  end

  # GET /admin
  # This prepares the admin dashboard.
  def admin
    @teacher = current_teacher
    @school = School.find(current_teacher.school_id)
  end 

  # GET /admin_report
  #This method prepares the admin_report view.
  def admin_report
    @current_teacher = current_teacher
    @school = School.find(@current_teacher.school_id)
    @students = Student.where(school_id: current_teacher.school_id).order('full_name ASC')
    @teachers = Teacher.where(school_id: current_teacher.school_id).order('full_name ASC')
    @squares = Square.where(school_id: current_teacher.school_id).order('full_name ASC')
  end

  # GET /super
  # prepares variables for the super view
  def super
    @teacher = Teacher.first
    @schools = School.all
    @school =  School.find(Teacher.first.school_id)
  end

  # PATCH /super
  # updates the focus school of the super user
  def update_super_focus
    @teacher = Teacher.first
    if ! @teacher.update(super_params)
      flash[:danger] = "Error changing Super focus school"
    end
    redirect_to super_path
  end

  # GET /teachers/1
  # View for a teacher. It sets up pagination similarly to the teacher index.
  def show
    @teacher = Teacher.find(params[:id])
    @students = @teacher.students.order('full_name ASC')
    @students_at_school = Student.where(school_id: @teacher.school_id).order('full_name ASC')
    @students_not_in_roster = Student.where(school_id: @teacher.school_id).where.not(id: @teacher.students).order('full_name ASC')

    #Whenever this page is visited, it updates the roster for the admin.
    if @teacher.admin

      #https://stackoverflow.com/questions/3343861/how-do-i-check-to-see-if-my-array-includes-an-object
      @students_at_school.each do |student|
        unless @students.include?(student)
          @teacher.students << Student.find(student.id)
        end
      end
    
      @students = @students_at_school
      @students_not_in_roster = []
    else
      # add student case
      if params[:add_student]  &&  (params[:add_student_id] != nil)
        @teacher.students << Student.find(params[:add_student_id])
        redirect_to @teacher
      # remove student case
      elsif params[:remove_student]  &&  (params[:remove_student_id] != nil)
        @teacher.students.delete(Student.find(params[:remove_student_id]))
        redirect_to @teacher
      end
    end
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
      params.require( :teacher).permit( :user_name, :full_name, :email, :admin,
          :password, :password_confirmation, :color, :icon, :description,
          :school_id, :suspended)
    end

    def edit_profile_params
      params.require(:teacher).permit( :user_name, :full_name, :email, :admin, 
            :color, :icon, :description)
    end

    def edit_login_settings_params
      params.require(:teacher).permit( :suspended, :password, :password_confirmation)
    end

    def edit_password_params
      params.require(:teacher).permit( :password, :password_confirmation)
    end

    def password_params
      params.require(:teacher).permit( :current_password, :password, :password_confirmation)
    end

    def access_params
      params.require(:teacher).permit( :access_all_students)
    end

    def super_params
      params.require(:teacher).permit(:school_id)
    end

    # can only access teachers and info from the same school
    def same_school
      if current_teacher.school_id != Teacher.find(params[:id]).school_id
        redirect_to home_path, :flash => { :notice => "You can't access other schools." }
      end
    end

    def all_sessions
      @the_sessions = []
      teachers = Teacher.where(school_id: current_teacher.school_id)
      teachers.each do |the_teacher|
        some_sessions = Session.where( session_teacher: the_teacher)
        @the_sessions << some_sessions 
      end
      return @the_sessions
    end

end
