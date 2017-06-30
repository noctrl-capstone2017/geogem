# Kevin M:
# This is almost pure scaffolding with the show/edit/index stuff removed, leaving only
# the necessary stuff for changing things. The update/create/destroy stuff
# has also been gutted to remove redirection.

class RosterStudentsController < ApplicationController
  before_action :set_roster_student, only: [:update, :destroy]

  #Creates a roster_student.
  def create
    @roster_student = RosterStudent.new(roster_student_params)
    @roster_student.save
  end

  #Updates a roster_student.
  def update
    @roster_student.update(roster_student_params)
  end

  #Destroys a roster_student.
  def destroy
    @roster_student.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_roster_student
      @roster_student = RosterStudent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def roster_student_params
      params.require(:roster_student).permit(:student_id, :teacher_id)
    end
end
