#Author: Ricky Perez
#Description: This contains the methods and helpers used for the roster square page

class RosterSquaresController < ApplicationController
  before_action :set_roster_square, only: [:show, :edit, :update]

  helper_method :set_square_name    # methods used in roster square views
  helper_method :set_square_color
  helper_method :set_square_id
  helper_method :set_square_desc
  helper_method :set_roster_id
  helper_method :is_student_square

  # GET /roster_squares
  # GET /roster_squares.json
  def index
    @roster_squares = RosterSquare.all
  end

  # GET /roster_squares/1
  # GET /roster_squares/1.json
  def show
    
  end

  # GET /roster_squares/new
  def new
    @roster_square = RosterSquare.new
  end

  # GET /roster_squares/1/edit
  # edit the behavior squares available to a student
  def edit
    @roster_square = RosterSquare.new
    @roster_squares = RosterSquare.all

    @student = Student.find_by_id(params[:id])
    @student_squares = RosterSquare.where(student_id: @student.id)
    @not_student_squares = []

    #Set the squares for the specific school
    @school_squares = Square.where(school_id: @student.school_id)
    @square = Square.find_by_id(params[:id])
    @squares = Square.all
    
    if params[:remove_square]
      if params[:remove_square_id] != nil
        @roster_squares.delete(RosterSquare.find(params[:remove_square_id]))
        flash[:success] = 'Roster square was successfully removed.'
        redirect_to  "/roster_squares/#{params[:id]}/edit"
      end
    end
  end

  #Below are helpers methos that when called allow you to check certain fields
  #that would otherwise be unavailable
  def set_roster_id (roster_square)
    @roster_id = RosterSquare.find(roster_square.square_id).screen_name
  end
  
  def set_square_id (roster_square)
    @square_id = Square.find(roster_square.square_id).id
  end
  
  def set_square_desc (roster_square)
    @square_desc = Square.find(roster_square.square_id).full_name
  end
  
  def set_square_name (roster_square)
    @square_name = Square.find(roster_square.square_id).screen_name
  end
  
  def set_square_color (roster_square)
    @square_color = Square.find(roster_square.square_id).color
  end
  
  #Checks if the square is used for the specific student. Unused at the moment
  def is_student_square(square)
    @is_square = false
    @student_squares.each do |student_square|
      if square.id == student_square.square_id
        @is_square = true
        break
      end
      
      if @is_square != true
        @is_square = false
      end 
      
    end
    if @is_square == false
      @not_student_squares.push(square)
    end
    @is_square
  end
  
  # POST /roster_squares
  # POST /roster_squares.json
  def create
    @roster_square = RosterSquare.new(roster_square_params)
    @student = Student.find_by_id(params[:id])
    @squares = Square.all
    @square = Square.find_by_id(params[:id])
    @student_squares = RosterSquare.where(student_id: @student)
      if @roster_square.save
        flash[:success] = 'Roster square was successfully added.'
        redirect_to "/roster_squares/#{@roster_square.student_id}/edit"
      else
        format.html { render :new }
        format.json { render json: @roster_square.errors, status: :unprocessable_entity }
      end
  end

  # PATCH/PUT /roster_squares/1
  # PATCH/PUT /roster_squares/1.json
  def update
    respond_to do |format|
      if @roster_square.update(roster_square_params)
        format.html { redirect_to "/roster_squares/#{@roster_square.student_id}/edit", notice: 'Roster square was successfully updated.' }
        format.json { render :show, status: :ok, location: @roster_square }
      else
        format.html { redirect_to "/roster_squares/#{@roster_square.student_id}/edit", notice: 'Roster square was successfully updated.' }
        format.json { render json: @roster_square.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_roster_square
      #Sets the edit page to the specified student
      @roster_squares = RosterSquare.all
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roster_square_params
      params.require(:roster_square).permit(:square_id, :student_id)
    end
  
end
