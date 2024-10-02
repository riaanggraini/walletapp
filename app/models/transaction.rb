class Transaction < ApplicationRecord
  # Associations
  belongs_to :source_wallet, class_name: 'Wallet', foreign_key: 'source_wallet_id', optional: true
  belongs_to :target_wallet, class_name: 'Wallet', foreign_key: 'target_wallet_id'

  # Validations
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true, inclusion: { in: %w[credit debit], message: "%{value} is not a valid transaction type" }

  # Custom validations
  validate :source_wallet_required_for_debit

  private

  def source_wallet_required_for_debit
    if transaction_type == 'debit' && source_wallet.nil?
      errors.add(:source_wallet, "must be present for debit transactions")
    end
  end
end
