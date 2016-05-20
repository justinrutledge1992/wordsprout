class User < ActiveRecord::Base
    
###### Active Record Assosciations ######
    has_many :entries
    
###### Declarations ######
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    attr_accessor :remember_token

###### Before Save ######
    before_save {self.email = email.downcase }
        
###### Password ######
    has_secure_password 
        #Adds 'password_digest' attribute to DB
        #Adds a pair of virtual attributes 'password' and 'password_confirmation'
        #Adds 'authenticate' method that returns the user when password is correct and false otherwise
        
###### Validations ######
    validates :firstname, 
        presence: true
        
    validates :lastname, 
        presence: true
        
    validates :email, 
        presence: true, 
        length: { maximum: 255 }, 
        format: { with: VALID_EMAIL_REGEX }, 
        uniqueness: { case_sensitive: false }
    
    validates :password, 
        presence: true, length: { minimum: 6 }
  
    
###### Helper Methods ######
    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
            BCrypt::Engine.cost
            BCrypt::Password.create(string, cost: cost)
    end
    
    # Returns a random token.
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    # Creates a token in the database for user login persistence
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    # Returns true if the given token matches the digest
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        # else...
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    # Forgets a user.
    def forget
        update_attribute(:remember_digest, nil)
    end


end