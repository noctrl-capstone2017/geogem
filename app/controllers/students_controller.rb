# Authors: Ricky Perez & Michael Loptien

class StudentsController < ApplicationController

  include TeachersHelper

  before_action :set_student, only: [:show, :edit, :update, :destroy]
  before_action :set_school   #set up the school info for the logged in teacher
  before_action :is_admin, only: [:index]       #make sure only admins can reach any of this

  # GET /students
  # GET /students.json
  def index
    # Admin only, list just that schools students
    @students = Student.where(school_id: current_teacher.school_id)
    
    # Paginate those students and order by full_name
    @students = @students.order('full_name ASC')
    @students = @students.paginate(page: params[:page], :per_page => 10)
    
    # Make a @sessions list for each student in the @studens list
    @sessions = Session.where(session_student: @students.ids)
  end

  # GET /students/1
  # GET /students/1.json
  def show
    @student = Student.find(params[:id])
  end

  # GET /students/new
  def new
    @student = Student.new
    @student.color = "aqua"
    @student.icon = "bug"
  end

  # GET /students/1/edit
  def edit
  end
  
  #Author: Carolyn C
  #For analysis purposes
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
  
  #Author: Carolyn C
  #For Reports purposes
  def analysis2
    @student = Student.find(params[:id])
    @sessions = Session.where(session_student: @student.id)
    if params[:report]
        #redirect_to report1_path(params[:id])
    end
  end
  
  #Author: Carolyn C
  #For Reports purposes
  def analysis3
    @student = Student.find(params[:id])
    @sessions = Session.where(session_student: @student.id)
    if params[:report]
        #redirect_to report1_path(params[:id])
    end
  end
  
  #Author: Carolyn C
  #For Reports purposes
  def analysis4
    @student = Student.find(params[:id])
    @sessions = Session.where(session_student: @student.id)
    if params[:report]
        #redirect_to report1_path(params[:id])
    end
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

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    @student = Student.find(params[:id])
    if @student.update(student_params)
        flash[:success] = "Student was successfully updated."
        redirect_to students_url
    else
      render 'edit'
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    flash[ :success] = "Student was successfully destroyed."
    redirect_to students_url
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
