# Authors: Ricky Perez & Michael Loptien

class StudentsController < ApplicationController
  include TeachersHelper
  include UxHelper

  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_school   #set up the school info for the logged in teacher
  before_action :is_admin, only: [:index]       #make sure only admins can reach any of this

  # GET /students
  # list all students as an Admin
  def index
    # Admin only, list just that schools students
    @students = Student.where(school_id: current_teacher.school_id)
    
    # Paginate those students and order by full_name
    @students = @students.order('full_name ASC')
    @students = @students.paginate(page: params[:page], :per_page => 10)
    
    # Make a @sessions list for each student in the @studens list
    @sessions = Session.where(session_student: @students.ids)
  end

  # GET /students/new
  # prep creation of a new student
  def new
    @student = Student.new
    @student.color = studentColors.first
    @student.icon = studentIcons.first
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)
    if @student.save
      flash[:success] = "Student was successfully created."
      redirect_to students_url
    else
      render 'new'
    end
  end

  # GET /students/1
  # show a student, the prelude to all work: sessions and analysis
  def show
    @student = Student.find(params[:id])

    # student's roster of default/recommended behavior squares
    @student_roster_squares = RosterSquare.where(student_id: @student.id)

    # all behavior squares at the school
    @school_squares = Square.where(school_id: @student.school_id)
  end
  
  # GET /students/1/edit
  # edit student page
  def edit
    @student = Student.find(params[:id])
  end

  #GET /students/1/edit2
  # assign recommended squares to student
  def edit2
    @student = Student.find(params[:id])
    @squares = @student.squares
    @squares_at_school = Square.where(school_id: @student.school_id)
    @squares_not_in_roster = Square.where(school_id: @student.school_id).where.not(id: @student.squares)
  end

  # PATCH/PUT /students/1 and /students/1/edit
  # update student does multiple things
  def update
    if params[:start_session]
      start_session
    elsif params[:analysis]
      redirect_to analysis_student_path(@student)
    elsif params[:edit2_add]  ||  params[:edit2_remove]
      update2_squares
    else
      # basic case: edit student attributes
      @student = Student.find(params[:id])
      if @student.update(student_params)
          flash[:success] = "Student was successfully updated."
          redirect_to edit_student_path(@student)
      else
        render 'edit'
      end
    end
  end

  # start behavioral session for student-teacher combo
  def start_session
    @student = Student.find(params[:id])
    @session = Session.new
    @session.session_teacher = current_teacher.id
    @session.session_student = @student.id
    @session.start_time = Time.now
    if @session.save
      # flash[ :success] = "Session was successfully created."
      redirect_to @session
    else
      render @student
    end
  end

  # add/remove a student's recommended squares
  # note: this is a kissin' cousin to update3_access in the teachers controller
  def update2_squares
    # add square to roster
    if params[:edit2_add]  
      if params[:add_square_id].present?
        @student.squares << Square.find(params[:add_square_id])
      end
      redirect_to edit2_student_path(@student)

    # remove square from roster
    elsif params[:edit2_remove]
      if params[:remove_square_id].present?
        @student.squares.delete(Square.find(params[:remove_square_id]))
      end
      redirect_to edit2_student_path(@student)
    end
  end

  # DELETE /students/1
  # unused
  def destroy
    # @student.destroy
    # flash[ :success] = "Student was successfully destroyed."
    # redirect_to students_url
  end

  # for Reports purposes, Author: Carolyn C
  def analysis
    @student = Student.find(params[:id])
    if params[:analysis_report]
      redirect_to analysis2_student_path( @student)
    elsif params[:analyze_csv]
      redirect_to analysis3_student_path( @student)
    elsif params[:analyze_charts]
      redirect_to analysis4_student_path( @student)
    end
  end
  
  # for Reports purposes, Author: Carolyn C
  def analysis2
    @student = Student.find(params[:id])
    @sessions = Session.where(session_student: @student.id)
    if params[:report]
        #redirect_to report1_path(params[:id])
    end
  end
  
  # for Reports purposes, Author: Carolyn C
  def analysis3
    @student = Student.find(params[:id])
    @sessions = Session.where(session_student: @student.id)
    if params[:report]
        #redirect_to report1_path(params[:id])
    end
  end

  # for Reports purposes, Author: Carolyn C
  def analysis4
    @student = Student.find(params[:id])
    @sessions = Session.where(session_student: @student.id)
    if params[:report]
        #redirect_to report1_path(params[:id])
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Used for getting the school values for the logged in teacher 
    def set_school
      @school = School.find(current_teacher.school_id)
      @color  = @school.color
      @screen_name = @school.screen_name
      @full_name = @school.full_name
      @icon = @school.icon
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:full_name, :icon, :color, 
            :session_interval, :contact_info,  :school_id)
    end
end
