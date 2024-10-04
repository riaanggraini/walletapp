module ResponseMessages
  LOGIN_SUCCESS = "Login successful".freeze
  LOGIN_FAILED = "Invalid email or password".freeze
  MISSING_EMAIL_PASSWORD = "Email and password are required".freeze
  UNAUTHORIZED_USER_NOT_FOUND = "Unauthorized - User not found".freeze
  UNAUTHORIZED_INVALID_TOKEN = "Unauthorized - Invalid or missing token".freeze
  INSUFFICIENT_BALANCE_SOURCE = "Insufficient balance in the source wallet".freeze

  def self.created(field)
    "#{field} successfuly created"
  end

  def self.updated(field)
    "#{field} successfuly updated"
  end

  def self.missing_value(field)
    "#{field} is missing"
  end

  def self.missing_key(field)
    "#{field} key is missing"
  end

  def self.not_found(field)
    "#{field} Not Found"
  end

  def self.found(field)
    "#{field} Found"
  end

  def self.stock_not_found(field)
    "Stock with symbol #{field} Not Found"
  end
end
