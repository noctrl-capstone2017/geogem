#author Matthew O & Alex P
class SessionEvent < ApplicationRecord
  belongs_to :session
  validates :session_id, presence: true
end
