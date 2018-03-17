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
  # intervals start at 0 internally, but at 1 for the user, hence the +1
  def ux_event_interval( event)
    event.interval_num.present? ? (event.interval_num+1) : " "
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
        "Duration: " << Time.at(duration).utc.strftime("%-M mins, %-S secs")
      else 
        "Duration: " << Time.at(duration).utc.strftime("%-S secs")
      end
    else
      ""
    end
  end

end
