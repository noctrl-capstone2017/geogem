# Authors: Ricky Perez & Michael Loptien

class Square < ApplicationRecord
    # Ensures that none of the fields are empty
    validates :screen_name, presence: true
    validates :tracking_type, presence: true
    validates :color, presence: true
    validates :description, presence: true    

    #Creates the relationship of what teachers the student belongs too
    has_many :passive_relationships, class_name:  "RosterSquare",
                                     foreign_key: "square_id",
                                     dependent:   :destroy
    has_many :students, through: :passive_relationships, source: :student
end
