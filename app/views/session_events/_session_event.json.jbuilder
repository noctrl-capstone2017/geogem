json.extract! session_event, :id, :behavior_square_id, :square_press_time, :duration_end_time, :session_id, :created_at, :updated_at
json.url session_event_url(session_event, format: :json)
