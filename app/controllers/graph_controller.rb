class GraphController < ApplicationController
  def main #selects events from sessions 3 to 6
    @graphData = SessionEvent.where(session_id:(3..6))
  end

  def example
    @allSessions = Session.all
    @studentSessions = Session.where(session_student:1)
    @last2sessions = @studentSessions.last(2)
    @sesh1Events = SessionEvent.where(session_id:1)
    @otherStudentSesh = Session.where(session_student:1).first(1)
  end

  def random
  end

  def todo
  end

  def other
  end
end
