class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]
  before_action :special_navbar_and_layout, only: [:show]

  # GET /sessions
  # unused
  def index
    @sessions = Session.all
  end

  # GET /sessions/new
  # unused?
  def new
    @session = Session.new
  end

  # POST /sessions
  # unused?
  def create
    @session = Session.new(session_params)

    respond_to do |format|
      if @session.save
        format.html { redirect_to @session }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /sessions/1/edit
  # unused?
  def edit
  end

  # PATCH/PUT /sessions/1
  # unused?
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /sessions/1
  # prep to show session... leads to show view, which is the BIG page 
  # where all the session action happens
  def show
    if @session.end_time != nil
      flash[:danger] = 'This session has already ended and cannot be changed.'
      redirect_to end_session_url( @session)
    else
      @student = Student.find(@session.session_student)
      @teacher = Teacher.find(@session.session_teacher)
      @school = School.find( @student.school_id)
      @squares = get_student_squares( @student)
    end
  end

  # handles the end of a session
  def end_session
    @session = Session.find(params[:id])

    #if time is already set for the sessions do not reset it
    if @session.start_time.nil?
      if params[:end_sess2]
        @session.start_time = params[:start2].to_s
        @session.save
      end
    end
    if @session.end_time.nil?
      @session.end_time = Time.now
      @session.save
      # if params[:end_sess2]
      #   @session.end_time = params[:end2].to_s
      #   @session.save
      # end
    end

    @student = Student.find(@session.session_student)
    @teacher = Teacher.find(@session.session_teacher)
    @events = SessionEvent.where( session_id: @session)
    @notes = SessionNote.where( session_id: @session)
    @squares = get_student_squares( @student)

    # @square_type = @squares
  end

  # DELETE /sessions/1
  # unused
  def destroy
    @session.destroy
    respond_to do |format|
      format.html { redirect_to sessions_url, notice: 'Session was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session
      @session = Session.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_params
      params.require(:session).permit(:start_time, :end_time, :session_teacher, :session_student)
    end

    # returns the behavior squares for a student
    # This is either the default/recommended squares in the student's roster, 
    # or if none, then it's all the behavior squares at the student's school.
    def get_student_squares( student)
      the_squares = student.squares
      if the_squares.nil?  ||  the_squares.empty?
        # no default squares for student, so use all squares at the school
        the_squares = Square.where(school_id: student.school_id)
      end
      the_squares
    end

end
