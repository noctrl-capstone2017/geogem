class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]
  before_action :disable_nav, only: [:show]
  
  # GET /sessions
  # GET /sessions.json
  def index
    @sessions = Session.all
  end
  
  #Alex P + Matthew O
  def end_session
    @session = Session.find(params[:id])
    #if time is already set for the sessions do not reset it
    if(@session.start_time.nil? and @session.end_time.nil?)
      #allows for 2 end session buttons
      if params[:end_sess1]
        @session.start_time = params[:start].to_s
        @session.end_time = params[:end].to_s
        @session.save
      elsif params[:end_sess2] 
        @session.start_time = params[:start2].to_s
        @session.end_time = params[:end2].to_s
        @session.save
      end
    end
    @student = Student.find(@session.session_student)
    @teacher = Teacher.find(@session.session_teacher)
    @squares = @student.squares
    @square_type = @squares
    
  end

  # GET /sessions/1
  # GET /sessions/1.json
  # Alex P + Matthew O
  def show
    @student = Student.find(@session.session_student)
    @teacher = Teacher.find(@session.session_teacher)
  end

  # GET /sessions/new
  def new
    @session = Session.new
  end

  # GET /sessions/1/edit
  def edit
  end

  # POST /sessions
  # POST /sessions.json
  def create
    @session = Session.new(session_params)

    respond_to do |format|
      if @session.save
        format.html { redirect_to @session, notice: 'Session was successfully created.' }
        format.json { render :show, status: :created, location: @session }
      else
        format.html { render :new }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
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

  # DELETE /sessions/1
  # DELETE /sessions/1.json
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
end
