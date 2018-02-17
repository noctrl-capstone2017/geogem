# Authors: Ricky Perez & Michael Loptien

class StudentsController < ApplicationController
  include TeachersHelper
  include UxHelper

  before_action :set_school   #set up the school info for the logged in teacher
  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :is_admin, only: [:index]     #make sure only admins can reach any of this
  before_action :emerald_params,  only: [:emerald_export]

  # GET /students
  # list all students as an Admin
  def index
    # Admin only, list just that schools students
    @students = Student.where(school_id: current_teacher.school_id)
    
    # Paginate those students and order by full_name
    @students = @students.order('LOWER(full_name) ASC')
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
  # admin page - Setup student screen
  def edit
    @student = Student.find(params[:id])
  end

  # GET /students/1/edita
  # admin setup to edit a students's properties
  def edita
    @student = Student.find(params[:id])
  end

  #GET /students/1/editb
  #  admin setup to assign behavior squares to student
  def editb
    @student = Student.find(params[:id])
    @squares = @student.squares
    @squares_at_school = Square.where(school_id: @student.school_id)
    @squares_not_in_roster = Square.where(school_id: @student.school_id).where.not(id: @student.squares)
  end

  # GET /students/1/editc
  # admin setup of a student's behavior session
  def editc
    @student = Student.find(params[:id])
  end

  # PATCH/PUT /students/1 and /students/1/edit
  # update student does multiple things
  def update
    if params[:editb_add]  ||  params[:editb_remove]
      updateb_squares
    elsif params[:editc]
      updatec_setup_session
    elsif params[:start_session]
      start_session
    elsif params[:analysis]
      redirect_to analysis_path(@student)
    else
      # basic case: edit A - edit student attributes
      @student = Student.find(params[:id])
      if @student.update(student_params)
          flash[:success] = "Student was successfully updated."
          redirect_to edit_student_path(@student)
      else
        render 'edit'
      end
    end
  end

  # add/remove a student's recommended squares
  # note: this is a kissin' cousin to update3_access in the teachers controller
  def updateb_squares
    # add square to roster
    if params[:editb_add]  
      if params[:add_square_id].present?
        @student.squares << Square.find(params[:add_square_id])
      end
      redirect_to editb_student_path(@student)

    # remove square from roster
    elsif params[:editb_remove]
      if params[:remove_square_id].present?
        @student.squares.delete(Square.find(params[:remove_square_id]))
      end
      redirect_to editb_student_path(@student)
    end
  end

  # setup a behavior session for a student
  def updatec_setup_session
    if @student.update(setup_session_params)
      flash[:success] = "Session setup was successfully updated."
      redirect_to edit_student_path(@student)
    else
      render 'edit'
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
      redirect_to @session
    else
      render @student
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
  end
  
  # Emerald Export which writes CSV for session data
  def analysis_emerald
    if params[:do_emerald]
      # do the CSV export
      @student = Student.find( params[:id])
      @session = Session.find( params[:session_id])
      notes_flag = params[:include_notes] ? true: false

      events = SessionEvent.where( session_id: params[:session_id])
      send_data events.to_csv( notes_flag), filename: emerald_filename( @student, @session)
    else
      # setup the form for Emerald export
      @student = Student.find(params[:id])
      @sessions = Session.where(session_student: @student.id)
    end
  end

  # Setup for Topaz Form which shows a printable session form
  def analysis_topaz
    @student = Student.find(params[:id])
    @teacher = current_teacher
    @squares = @student.squares
    @num_intervals = topaz_num_intervals(@student)
  end

  # Ruby Report creates PDF for one behavior square over time
  def analysis_ruby
    @student = Student.find(params[:id])
  end


  # Do the Emerald Export; write session data to a CSV file
  # def emerald_export
  #   @student = Student.find( params[:id])
  #   @session = Session.find( params[:session_id])
  #   notes_flag = params[:include_notes] ? true: false

  #   events = SessionEvent.where( session_id: params[:session_id])
  #   send_data events.to_csv( notes_flag), filename: emerald_filename( @student, @session)
  # end

  # for Reports purposes, Author: Carolyn C
  # def analysis2
  #   @student = Student.find(params[:id])
  #   @sessions = Session.where(session_student: @student.id)
  #   if params[:report]
  #       #redirect_to report1_path(params[:id])
  #   end
  # end
  
  # for Reports purposes, Author: Carolyn C
  # def analysis3
  #   @student = Student.find(params[:id])
  #   @sessions = Session.where(session_student: @student.id)
  #   if params[:report]
  #       #redirect_to report1_path(params[:id])
  #   end
  # end

  # for Reports purposes, Author: Carolyn C
  # def analysis4
  #   @student = Student.find(params[:id])
  #   @sessions = Session.where(session_student: @student.id)
  #   if params[:report]
  #       #redirect_to report1_path(params[:id])
  #   end
  # end

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
      params.require(:student).permit(:full_name, :icon, :color, :contact_info, :school_id)
    end

    def setup_session_params
      params.require(:student).permit( :session_interval, 
            :session_interval_counting, :session_instructions)
    end

    def emerald_params
      params.permit(:session_id, :include_notes)
    end

    # Emerald export file names are: gg_<student>_<day>.csv
    # For example: gg_jimmy_oct18.csv
    def emerald_filename( student, session)
      # first 8 non-black chars in student's name
      student_part = student.full_name.delete(' ').strip.truncate( 8)

      # date formatted: jan01_2017
      date_part = session.created_at.strftime("%b%d")

      filename = "gg_" << student_part << "_" << date_part << ".csv"
      filename.downcase
    end

    def topaz_num_intervals( student)
      case student.session_interval
      when 5
        num = 12
      when 15
        num = 16
      when 30
        num = 16
      else
        num = 8
      end
      return num
    end
end
