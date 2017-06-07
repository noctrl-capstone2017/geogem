json.extract! session, :id, :start_time, :end_time, :session_teacher, :session_student, :created_at, :updated_at
json.url session_url(session, format: :json)
