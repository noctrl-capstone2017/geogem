#Authors Alex P, Matthew O, Debra J
class SessionEventsController < ApplicationController
  before_action :set_session_event, only: [:show, :edit, :update, :destroy]
  

  # GET /session_events
  # GET /session_events.json
  def index
    @session_events = SessionEvent.all
  end

  # GET /session_events/1
  # GET /session_events/1.json
  def show
  end

  # GET /session_events/new
  def new
    @session_event = SessionEvent.new
  end

  # GET /session_events/1/edit
  def edit
  end

  # POST /session_events
  # POST /session_events.json
  #author: Matthew O & Alex P
  def create
    @session_event = SessionEvent.new
    @session_event.behavior_square_id = params[:behavior_id]
    @session_event.square_press_time = params[:start_time].to_s
    @session_event.duration_end_time = params[:end_time].to_s
    #Taylor S for debugging
    #@session_event.square_press_time = Time.now
    #@session_event.duration_end_time = Time.now + 5*60
    @session_event.session_id = params[:session_id]

    respond_to do |format|
      if @session_event.save
        format.any { render :json => {:response => 'Success' },:status => 200  }
      else
        format.html { render :new }
        format.json { render json: @session_event.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /session_events/undo
  # POST /session_events.json
  #author: Matthew O & Alex P
  def undo
    @session_event = SessionEvent.where(session_id: params[:session_id], behavior_square_id: params[:behavior_square_id]).last()
    @session_event.destroy
    respond_to do |format|
      format.any { render :json => {:response => 'Success' },:status => 200  }
    end
  end

  # PATCH/PUT /session_events/1
  # PATCH/PUT /session_events/1.json
  def update
    respond_to do |format|
      if @session_event.update(session_event_params)
        format.html { redirect_to @session_event, notice: 'Session event was successfully updated.' }
        format.json { render :show, status: :ok, location: @session_event }
      else
        format.html { render :edit }
        format.json { render json: @session_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /session_events/1
  # DELETE /session_events/1.json
  def destroy
    @session_event.destroy
    respond_to do |format|
      format.html { redirect_to session_events_url, notice: 'Session event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_session_event
      @session_event = SessionEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_event_params
      params.require(:session_event).permit(:behavior_square_id, :square_press_time, :duration_end_time, :session_id)
    end
end
