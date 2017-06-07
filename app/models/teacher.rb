# author: Kevin M, Tommy B
# Teacher model validation, methods, and more!

class Teacher < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token, :current_password
  before_save   :downcase_email, :color_check, :super_check
  ###REGEX###
  #Only allows legit email formatting
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  
  #Prohibits any whitespace character (spaces, tabs, ¶, etc)
  VALID_USER_NAME_REGEX = /\A[\S]+\z/
  
  #Alphanumerical stuff only.
  VALID_SCREEN_NAME_REGEX = /\A[A-Za-z\d]+\z/
  
  ###VALIDATIONS###
  validates :user_name,  presence: true, length: { maximum: 75 },
                         uniqueness: { case_sensitive: false },  
                         format: { with: VALID_USER_NAME_REGEX }
                         
  validates :full_name, presence: true, length: { maximum: 75 }
  
  #https://stackoverflow.com/questions/808547/fully-custom-validation-error-message-with-rails
  #Screen_name is seen as "Teacher ID" by the user. We change how its errors are displayed in
  # config/locales/en.yml, check it out!
  validates :screen_name, presence: true, length: { maximum: 8 },
                    format: { with: VALID_SCREEN_NAME_REGEX } 
  
  validates :icon,  presence: true
  validates :color, presence: true
  
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :powers, presence: true
  validates :school_id, presence: true

  validates :password, presence: true, length: { minimum: 6 }, allow_blank: true
  has_secure_password
  
  #Creates the relationship of what students belong to the teacher
  #author Matthew OBzera + Alexander Pavia
  has_many :active_relationships, class_name:  "RosterStudent",
                                  foreign_key: "teacher_id",
                                  dependent:   :destroy

  has_many :students, through: :active_relationships, source: :student


  ### METHODS ###
  # Returns a random token.
  def Teacher.new_token
    SecureRandom.urlsafe_base64
  end
  
  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = Teacher.new_token
    update_attribute(:remember_digest, Teacher.digest(remember_token))
  end
  
  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    return false if attribute.nil?
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  # Returns the hash digest of the given string.
  def Teacher.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end
    
    # Converts light blue to ltblue, so it can easily be drawn on in views.
    # 'light blue' isn't a color that's recognized by bootstrap, but 'ltblue' is!
    def color_check
      if self.color == 'light blue'
        self.color = 'ltblue'
      end
    end
    
    # Makes sure Bill doesn't accidentally remove his admin powers or suspend himself
    def super_check
      if self.user_name == 'profbill'
        self.powers = "Admin"
        self.suspended = "false"
      end
    end
end
