class Stock < ApplicationRecord
  # Associations
  has_many :wallets, dependent: :restrict_with_error

  # Validations
  validates :ticker, presence: true, uniqueness: true, length: { minimum: 1, maximum: 10 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
