#author Matthew O & Alex P
class SessionEvent < ApplicationRecord
  belongs_to :session
  validates :session_id, presence: true


  # return the duration of a session_event in number of seconds
  def duration_in_secs
    duration_end_time.to_i - square_press_time.to_i
  end

  # calc and then set the interval num for an event, requires the session object
  # Note - the event is NOT saved; I leave that to you
  def set_interval_num( session)
    time1 = Time.at(self.square_press_time)
    time2 = Time.at(session.start_time)
    delta = (time1.to_f - time2.to_f).to_i
    self.interval_num = delta / (session.session_interval * 60)
  end

  # write session events in CSV format... used by the Emerald Export screen
  def self.to_csv( include_notes = false)
    if include_notes
      header = %w(Num Time Event Type Duration(secs) Notes)
    else
      header = %w(Num Time Event Type Duration(secs))
    end

    num = 1
    CSV.generate do |csv|
      csv << header
      all.each do |event|
        event_square = Square.find( event.behavior_square_id)

        csv_time = event.square_press_time.in_time_zone('Central Time (US & Canada)').strftime("%H:%M")
        csv_event = event_square.screen_name
        # calling a helper in model code is weird
        # Source: https://stackoverflow.com/questions/29141093/helper-methods-for-models-in-rails
        csv_type = ApplicationController.helpers.ux_square_tracking_type( event_square)
        csv_duration = (csv_type == "Timer" ? event.duration_in_secs : 0)

        if include_notes
          csv << [ num, csv_time, csv_event, csv_type, csv_duration, "" ]
        else
          csv << [ num, csv_time, csv_event, csv_type, csv_duration ]
        end
        num += 1
      end

      if include_notes  &&  all.present?
        notes = SessionNote.where( session_id: first.session_id)
        if ! notes.empty?
          notes.each do | each_note |
            note_time = each_note.created_at.in_time_zone('Central Time (US & Canada)').strftime("%H:%M")
            csv << [num, note_time, "Note", "Note", 0, each_note.note ]
            num += 1
          end
        end
      end
    end
  end

end
