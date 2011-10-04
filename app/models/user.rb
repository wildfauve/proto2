class User
  include Mongoid::Document
  
  field :name
  field :password_hash
  field :password_salt
  
  attr_accessible :name, :password
  
  attr_accessor :password
  
  before_save :encrypt_password
  
  def self.authenticate(name, password)  
      user = where(:name => name).first
      if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)  
        user  
      else  
        nil  
      end  
  end  
  
  def admin?
    self.name == "admin" ? true : false
  end
  
  
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
  
end