json.extract! student, :id, :full_name, :screen_name, :icon, :color, :contact_info, :description, :session_interval, :school_id, :created_at, :updated_at
json.url student_url(student, format: :json)
