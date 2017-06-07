class SessionNotesController < ApplicationController
  #before_action :set_session_note,  only: [:show, :edit, :update, :destroy]

  # GET /session_notes
  # GET /session_notes.json
  def index
    @session_note = SessionNote.new
    @session_notes = SessionNote.paginate(page: params[:page])
  end

  # GET /session_notes/1
  # GET /session_notes/1.json
  def show
  end

  # GET /session_notes/new
  def new
    @session_note = SessionNote.new
  end

  # GET /session_notes/1/edit
  def edit
  end

  # POST /session_notes
  # POST /session_notes.json
  def create
    @session_note = SessionNote.new
    @session_note.note = params[:note]
    @session_note.session_id = params[:session_id]
    respond_to do |format|
      if @session_note.save
         @session_note.created_at = params[:time].to_s
         @session_note.save
        format.any { render :json => {:response => 'Success' },:status => 200  }
      else
        format.html { render :new }
        format.json { render json: @session_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /session_notes/1
  # PATCH/PUT /session_notes/1.json
  def update
    respond_to do |format|
      if @session_note.update(session_note_params)
        format.html { redirect_to @session_note, notice: 'Session note was successfully updated.' }
        format.json { render :show, status: :ok, location: @session_note }
      else
        format.html { render :edit }
        format.json { render json: @session_note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /session_notes/1
  # DELETE /session_notes/1.json
  def destroy
    @session_note.destroy
    respond_to do |format|
      format.html { redirect_to session_notes_url, notice: 'Session note was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # # Use callbacks to share common setup or constraints between actions.
    # def set_session_note
    #   @session_note = SessionNote.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def session_note_params
      params.require(:session_note).permit(:note, :session_id, :created_at)
    end
end
