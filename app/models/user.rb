class User < ApplicationRecord
  # Associations
  has_many :wallets, dependent: :restrict_with_error
  has_many :transactions, dependent: :restrict_with_error

  # Virtual attribute for the password
  attr_accessor :password

  # Validations
  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, length: { minimum: 6 }, if: :password_required?
  
  # Hash the password before saving
  before_save :hash_password

  # Authenticate
  def authenticate(input_password)
    BCrypt::Password.new(encrypted_password) == input_password
  end

  private

  # Hash the password
  def hash_password
    if password.present?
      self.encrypted_password = BCrypt::Password.create(password)
    end
  end

  # other validations
  def password_required?
    encrypted_password.blank? || password.present?
  end
end
