# authors: Ricky Perez & Michael Loptien
# Model for Students

class Square < ApplicationRecord
    before_save   :color_check
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
