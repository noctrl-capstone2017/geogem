# Authors: Dakota B, Robert H

class SchoolsController < ApplicationController
  include TeachersHelper
  include LoginSessionHelper

  before_action :set_school, only: [:show, :edit, :update, :destroy]
  before_action :is_super, only: [:suspend, :backup, :restore, :index]
  before_action :is_admin, only: [:edit]


  # Used in the /schools route to display all schools
  def index
    @schools = School.paginate(page: params[:page], :per_page => 10).order('full_name ASC')
    @school = set_school
    set_school.full_name = params[:full_name]
  end

  # Used in the creation of new schools
  def new
    @school = School.new
  end

  # Used in addition the the new method in the creation of schools.
  def create
    @school = School.new(school_params)
    respond_to do |format|
      if @school.save
        format.html { redirect_to schools_path }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # edit school, get action
  def edit
    @school = School.find(params[:id])
  end

  # update school, post for edit schools
  def update
    if @school.update(school_params)
      redirect_to super_path
    else
      redirect_to schools_path
    end
  end


  # Used to pass information about which school will be backed up to the /backup page
  def backup
    @current_teacher = current_teacher
    @school = School.find(current_teacher.school_id)
  end

  # Used to pass information about which teacher at what school will be backed up to the /suspend page
  def suspend
    @current_teacher = current_teacher
    @school = School.find(current_teacher.school_id)
    # id = 1 written below refers to ProfBill, the SuperUser. He can't get deleted,
    # and therefore will never be in the set of teachers elligible for deletion
    @activeTeachers = Teacher.where(school_id: @school).where.not(id: 1, suspended: true)
    @teacher_count = @activeTeachers.count

    # Should update all the appropriate teachers to be suspended
    @activeTeachers.update_all(suspended: true)
  end 

  # Used to pass information to the /restore page about which teachers at what school will be restored.
  def restore
    @current_teacher = current_teacher
    @school = School.find(current_teacher.school_id)
    #id = 1 is ProfBill, the SuperUser. He can't get deleted in the first place. No point in restoring.
    @activeTeachers = Teacher.where(school_id: current_teacher.school_id).where.not(id: 1, suspended: false)

    @teacher_count = @activeTeachers.count
    
    # Should update all the appropriate teachers to be suspended
    @activeTeachers.update_all(suspended: false)
  end

  private

    def set_school
      @school =  School.find(Teacher.first.school_id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def school_params
      params.require(:school).permit(:full_name, :screen_name, :icon, :color, :email, :website, :description)
    end

    #Require a teacher to be suspended
    def suspended_teacher_params
      params.permit(:suspended)
    end

end
