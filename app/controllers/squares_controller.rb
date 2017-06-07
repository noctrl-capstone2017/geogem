# authors: Ricky Perez & Michael Loptien
# Controller for Squares 

class SquaresController < ApplicationController

  include TeachersHelper
  
  before_action :set_square, only: [:show, :edit, :update, :destroy]
  before_action :set_school         #set up the school info for the logged in teacher
  before_action :is_admin, only: [:index]           #make sure only admins can reach any of this
    
  # GET /squares
  # GET /squares.json
  def index
    #school admin. Only list that schools students
    @squares = Square.where(school_id: current_teacher.school_id)
    
    # Paginate those squares and order by screen_name
    @squares = @squares.order('screen_name ASC')
    @squares = @squares.paginate(page: params[:page], :per_page => 10)
  end

  # GET /squares/1
  # GET /squares/1.json
  def show
  end

  # GET /squares/new
  def new
    @square = Square.new
  end

  # GET /squares/1/edit
  def edit
  end

  # POST /squares
  # POST /squares.json
  def create
    @square = Square.new(square_params)
    if @square.save
      flash[:success] = "Square was successfully created."
      redirect_to squares_url
    else
      render 'new'
    end
  end

  # PATCH/PUT /squares/1
  # PATCH/PUT /squares/1.json
  def update
    @square = Square.find(params[:id])
    if @square.update(square_params)
       flash[:success] = "Square was successfully updated."
       redirect_to squares_url
     else
       render 'edit'
    end
  end

  # DELETE /squares/1
  # DELETE /squares/1.json
  def destroy
    @square.destroy
    respond_to do |format|
      format.html { redirect_to squares_url, notice: 'Square was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
    # Use callbacks to share common setup or constraints between actions.
    def set_square
      @square = Square.find(params[:id])
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
    def square_params
      params.require(:square).permit(:full_name, :screen_name, :color, :tracking_type, :description, :school_id)
    end
end
