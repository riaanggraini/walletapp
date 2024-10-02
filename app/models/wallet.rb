class Wallet < ApplicationRecord
  # Associations
  belongs_to :user, optional: true
  belongs_to :team, optional: true
  belongs_to :stock, optional: true

  has_many :transactions, dependent: :restrict_with_error
  has_many :source_transactions, class_name: 'Transaction', foreign_key: 'source_wallet_id', dependent: :restrict_with_error
  has_many :target_transactions, class_name: 'Transaction', foreign_key: 'target_wallet_id', dependent: :restrict_with_error

  # Validations
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  # accosiation validations
  validate :only_one_association

  private

  def only_one_association
    if [user_id, team_id, stock_id].compact.size > 1
      errors.add(:base, "A wallet can only belong to one entity: user, team, or stock")
    end
  end
end
