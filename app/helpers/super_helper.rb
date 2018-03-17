# Super Helper - hacks for the Super User!
module SuperHelper

  # Returns the number of bad sessions; ones that have bad events.
  # This is a V0.5 hack.
  def v0dot5_num_bad_sessions() 
    bad_sesh = 0
    Session.all.each do | each_sesh |
      if v0dot5_is_session_bad?( each_sesh)
        bad_sesh += 1
      end
    end
    bad_sesh
  end

  # Returns the number of bad session events; one where interval_num is nil
  # This is a V0.5 hack.
  def v0dot5_num_bad_events()
    bad_events = 0
    SessionEvent.all.each do | each_event |
      if v0dot5_is_event_bad?( each_event)
        bad_events += 1
      end
    end
    bad_events
  end

  def v0dot5_num_sessions_without_end()
    bad_sesh = 0
    Session.all.each do | each_sesh |
      if ! each_sesh.end_time.present?
        bad_sesh += 1
      end
    end
    bad_sesh
  end

  # Fixes all the bad sessions in GeoGem. The number of sessions fixed is returned.
  # This is a V0.5 hack.  
  def v0dot5_fix_bad_sessions() 
    fixed_sesh = 0
    Session.all.each do | each_sesh |
      if v0dot5_is_session_bad?( each_sesh)
        v0dot5_fix_bad_events( each_sesh)
        fixed_sesh += 1
      end
    end
    fixed_sesh
  end

  private

    # Fix all the bad events in this session. This is a V0.5 hack.
    def v0dot5_fix_bad_events( sesh)
      events = SessionEvent.where( session_id: sesh.id)
      events.each do | each_event |
        if v0dot5_is_event_bad?( each_event)
          each_event.set_interval_num( sesh)
          each_event.save
        end
      end
    end
  
    # Returns true if the session is bad. A "bad" session has "bad" events in it.
    # This is a V0.5 hack.
    def v0dot5_is_session_bad?( sesh)
      events = SessionEvent.where( session_id: sesh.id)
      events.each do | each_event |
        if v0dot5_is_event_bad?( each_event)
          return true
        end
      end
      false     # this session is NOT bad
    end
  
    # Returns true if the session event is bad = interval_num is nil.
    # This is a V0.5 hack.
    def v0dot5_is_event_bad?( event)
      return event.interval_num.nil?
    end

end 
