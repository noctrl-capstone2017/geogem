module SessionEventsHelper

  # for ux/view, return event start time (square press time)
  def ux_event_start_time( event)
    event.square_press_time.in_time_zone('Central Time (US & Canada)').strftime("%l:%M %P")
  end

  # for ux/view, return event end time (only applicable for duration events)
  def ux_event_end_time( event)
    sq = Square.find( event.behavior_square_id)
    if sq.tracking_type == Square::TIMER
      event.duration_end_time.in_time_zone('Central Time (US & Canada)').strftime("%l:%M %P")
    else
      ""
    end
  end

  # returns the interval, within the session, that the event occurred
  def ux_event_interval( session, event)
    7
  end

  # for ux/view, return behavior square name
  def ux_event_behavior_square( event)
    sq = Square.find( event.behavior_square_id)
    sq.screen_name
  end

  # for ux/view, return behavior square type
  def ux_event_behavior_square_type( event)
    sq = Square.find( event.behavior_square_id)
    if sq.tracking_type == Square::COUNTER
      "Counter"
    elsif sq.tracking_type == Square::TIMER
      "Timer"
    else
      "???"
    end
  end

  # for ux/view, return notes for an event
  def ux_event_notes( event)
    sq = Square.find( event.behavior_square_id)
    if sq.tracking_type == Square::TIMER
      duration = event.duration_in_secs
      if duration >= 60
        "Event duration was " << Time.at(duration).utc.strftime("%-M mins, %-S secs")
      else 
        "Event duration was " << Time.at(duration).utc.strftime("%-S secs")
      end
    else
      ""
    end
  end

end
