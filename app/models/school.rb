# Author: Robert H
class School < ApplicationRecord

  #Only allows legit email formatting
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :full_name, presence: true, length: { maximum: 75 }
  validates :icon, presence: true
  validates :color, presence: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }
             # uniqueness: { case_sensitive: false }
  validates :website, length: { maximum: 75 }
  validates :description, length: { maximum: 255 }

  # depricated
#  validates :screen_name,  length: { maximum: 8 }
           # format: { with: VALID_SCREEN_NAME_REGEX },
           # uniqueness: { case_sensitive: false}
           #produces 'screen name already taken' error if school id is taken
  
  #Prohibits any whitespace character (spaces, tabs, ¶, etc)
#  VALID_USER_NAME_REGEX = /\A[\S]+\z/

  #Alphanumerical stuff only.
#  VALID_SCREEN_NAME_REGEX = /\A[A-Za-z\d]+\z/

  private
    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
    
end
