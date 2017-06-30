# Authors: Dakota B, Robert H

class SchoolsController < ApplicationController
  include TeachersHelper
  include LoginSessionHelper

  before_action :set_school, only: [:show, :edit, :update]
  before_action :is_super, only: [:suspend, :backup, :restore, :index]
  before_action :is_admin, only: [:edit]


  # GET /schools - view all schools, sorted by full name
  def index
    @schools = School.paginate(page: params[:page], :per_page => 10).order('full_name ASC')
    @school = set_school
    set_school.full_name = params[:full_name]
  end

  # GET /schools/new - setup creation of a new school
  def new
    @school = School.new
  end

  # PUT schools/new - create the school with error-checking
  def create
    @school = School.new(school_params)
    if @school.save
      flash[ :success] = "School #{@school.full_name} was successfully created."
      redirect_to schools_path
    else
      render :new
    end
  end

  # GET /schools/#/edit - view a school, prep for updates
  def edit
    @school = School.find(params[:id])
  end

  # PUT /schools/#/edit - update school
  def update
    @school = School.find(params[:id])
    if @school.update(school_params)
      flash[ :success] = "School update successful, #{ @school.full_name }"
      redirect_to :schools
    else
      render :edit
    end
  end

  # GET /school_backup - prep for text backup of the Super focus school
  def backup
    @current_teacher = current_teacher
    @school = School.find(current_teacher.school_id)
  end

  # PATCH /school_backup - just do it; print backup file of Super focus school
  def do_backup
    flash[ :danger] = "Backup isn't working yet."
    redirect_to :super
  end

  # GET /school_suspend - prep to suspend all teacher logins at Super focus school
  def suspend
    @current_teacher = current_teacher
    @school = School.find(current_teacher.school_id)

    # "Active teachers" are those 1) at the school, 2) not yet suspended, 
    # and 3) not id=1, aka the Super user.
    # We don't want to suspend the Super login; that would be BAD.
    @activeTeachers = Teacher.where(school_id: @school).where.not(id: 1, suspended: true)
    @teacher_count = @activeTeachers.count
  end 

  # PATCH /school_suspend - just do it; suspend all teacher logins at Super focus school
  def do_suspend
    @school = School.find(current_teacher.school_id)
    @activeTeachers = Teacher.where(school_id: @school).where.not(id: 1, suspended: true)
    if @activeTeachers.update_all( suspended: true)
      flash[:success] = "All teacher logins suspended at #{@school.full_name}"
      redirect_to :super
    else
      flash[:danger] = "Error in suspend school"
      render suspend
    end
  end

  # GET /school_restore - prep to restore all teacher logins in Super focus school
  def restore
    @current_teacher = current_teacher
    @school = School.find(current_teacher.school_id)

    # "Inactive teachers" are those 1) at the school, 2) suspended, 
    # and 3) not id=1, aka the Super user.
    # We don't want to mess with the Super user login; that would be BAD.
    @inactiveTeachers = Teacher.where(school_id: current_teacher.school_id).where.not(id: 1, suspended: false)
    @teacher_count = @inactiveTeachers.count
  end

  # PATCH /school_restore - restore all logins at the Super's focus school
  def do_restore
    @school = School.find(current_teacher.school_id)
    @inactiveTeachers = Teacher.where(school_id: current_teacher.school_id).where.not(id: 1, suspended: false)
    if @inactiveTeachers.update_all( suspended: false)
      flash[:success] = "All teacher logins restored at #{@school.full_name}"
      redirect_to :super
    else
      flash[:danger] = "Error in restore school"
      render suspend
    end
  end

  private

    def set_school
      @school =  School.find(Teacher.first.school_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:full_name, :screen_name, :icon, :color, 
                        :email, :website, :description)
    end

    #Require a teacher to be suspended
    def suspended_teacher_params
      params.permit(:suspended)
    end

end
