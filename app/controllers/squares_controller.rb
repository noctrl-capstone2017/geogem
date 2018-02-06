# authors: Ricky Perez & Michael Loptien
# Controller for Squares 

class SquaresController < ApplicationController

  include TeachersHelper
  
  before_action :set_square, only: [:show, :edit, :update, :destroy]
  before_action :set_school         #set up the school info for the logged in teacher
  before_action :is_admin, only: [:index, :edit, :update]

  # GET /squares
  # GET /squares.json
  def index
    #school admin. Only list that schools students
    @squares = Square.where(school_id: current_teacher.school_id)
    
    # Paginate those squares and order by screen_name
    @squares = @squares.order('LOWER(screen_name) ASC')
    @squares = @squares.paginate(page: params[:page], :per_page => 10)
  end

  # GET /squares/1
  # GET /squares/1.json
  def show
  end

  # GET /squares/new
  def new
    @square = Square.new
    @square.color = "aqua"
    @square.tracking_type = Square::COUNTER
  end

  # GET /squares/1/edit
  def edit
    @square = Square.find(params[:id])
  end

  # GET /squares/1/edita
  # admin edit properties of a square
  def edita
    @square = Square.find(params[:id])
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
  # update square attributes
  def update
    @square = Square.find(params[:id])
    if @square.update(square_params_update)
       flash[:success] = "Square was successfully updated."
       redirect_to edit_square_path(@square)
     else
      render 'edita'
    end
  end

  # DELETE /squares/1
  # Unused
  def destroy
    @square.destroy
    flash[ :success] = "Square was successfully destroyed."
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
      params.require(:square).permit(:full_name, :screen_name, :color, 
            :tracking_type, :description, :school_id)
    end

    # update is more limiting on params that can be changed
    def square_params_update
      # BILL. Yuck. This is a fucking hack.
      # But I can't find a better way to handle a blank description.
      # On error, my cancel button was dying.
      # Html5 checks for an empty description, but not one with just whitespace.
      # But Rails kicks it out if it's just whitespace, so I set is to "None" here.
      # It's probably an error I need to catch using Javascript in the view. Maybe later.
      sq = params[:square]
      if sq[:description].blank?
        sq[:description] = "None"
      end
      params.require(:square).permit(:color, :description, :school_id)
    end
end
