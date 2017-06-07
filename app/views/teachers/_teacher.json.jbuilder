json.extract! teacher, :id, :user_name, :password_digest, :last_login, :full_name, :screen_name, :icon, :color, :email, :description, :powers, :school_id, :created_at, :updated_at
json.url teacher_url(teacher, format: :json)
