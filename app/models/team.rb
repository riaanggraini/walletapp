class Team < ApplicationRecord
  # Associations
  has_many :wallets, dependent: :restrict_with_error
  
  # Validations
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 100 }
  validates :description, length: { maximum: 500 }

  def total_balance
    wallets.sum(:balance)
  end
end
  