# authors: Ricky Perez & Michael Loptien
# Model for Students

class Student < ApplicationRecord
    before_save   :color_check
    # Ensures that none of the fields are empty
    validates :full_name, presence: true
    validates :screen_name, presence: true
    validates :color, presence: true
    validates :icon, presence: true
    validates :session_interval, presence: true

    #Creates the relationship of what teachers the student belongs too
    has_many :passive_relationships, class_name:  "RosterStudent",
                                     foreign_key: "student_id",
                                     dependent:   :destroy
    has_many :teachers, through: :passive_relationships, source: :teacher
    
    #Creates the relationship of what behaviors are tracked for the student
    has_many :active_relationships, class_name:  "RosterSquare",
                                     foreign_key: "student_id",
                                     dependent:   :destroy
    has_many :squares, through: :active_relationships, source: :square
 
 private   
    # SOURCED FROM Kevin M & Tommy B
    # Converts light blue to ltblue, so it can easily be drawn on in views.
    # 'light blue' isn't a color that's recognized by bootstrap, but 'ltblue' is!
    def color_check
      if self.color == 'light blue'
        self.color = 'ltblue'
      end
    end
end
