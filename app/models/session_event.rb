#author Matthew O & Alex P
class SessionEvent < ApplicationRecord
  belongs_to :session
  validates :session_id, presence: true

  # write session events in CSV format... used by the Emerald Export screen
  def self.to_csv
    header = %w(Num Time Event Type Duration)    # Event Type Duration
    #attributes = %w(csv_time)
    num = 1
    CSV.generate do |csv|
      csv << header
      all.each do |event|
        event_square = Square.find( event.behavior_square_id)

        csv_time = event.square_press_time.in_time_zone('Central Time (US & Canada)').strftime("%H:%M")
        csv_event = event_square.screen_name
        # calling a helper in model code is weird
        # Source: https://stackoverflow.com/questions/29141093/helper-methods-for-models-in-rails
        csv_type = ApplicationController.helpers.square_type_acroynm( event_square)
        tmp_duration = event.duration_in_secs
        csv_duration = "0"
        if( tmp_duration != 0)
          csv_duration = Time.at(tmp_duration).utc.strftime("%-M:%S")
        end

        csv << [ num, csv_time, csv_event, csv_type, csv_duration ]
        num += 1
      end
    end
  end

  # return the duration of a session_event in number of seconds
  def duration_in_secs
    duration_end_time.to_i - square_press_time.to_i
  end

end
