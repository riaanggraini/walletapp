class Transaction < ApplicationRecord
  # Associations
  belongs_to :source_wallet, class_name: 'Wallet', foreign_key: 'source_wallet_id'
  belongs_to :target_wallet, class_name: 'Wallet', foreign_key: 'target_wallet_id'

  # Enum for transaction types
  enum transaction_type: { debit: 'debit', credit: 'credit' }

  # Validations
  validates :amount, numericality: { greater_than: 0, message: ResponseMessages.missing_value('Amount must be greater than zero') }
  validates :transaction_type, presence: true, inclusion: { in: %w[debit credit], message: ResponseMessages.not_found('Transaction type') }
  validate :sufficient_balance_in_source_wallet, if: :debit?
  validate :source_wallet_required_for_debit, if: :debit?
  validate :source_user_is_active, if: -> { source_wallet.present? }
  validate :target_user_is_active, if: -> { target_wallet.present? }

  # Callbacks
  after_create :apply_transaction

  private

  # Ensure source wallet has sufficient balance for debit
  def sufficient_balance_in_source_wallet
    if source_wallet.balance < amount
      errors.add(:base, ResponseMessages::INSUFFICIENT_BALANCE_SOURCE)
    end
  end

  # Ensure source wallet is present for debit transactions
  def source_wallet_required_for_debit
    if source_wallet.nil?
      errors.add(:source_wallet, ResponseMessages.missing_value('Source wallet'))
    end
  end

  # Ensure target user has active status
  def target_user_is_active
    if target_wallet.user && target_wallet.user.status != 'active'
      errors.add(:target_wallet, ResponseMessages.user_cant_accept_fund("#{target_wallet.user.status}"))
    elsif target_wallet.user.nil?
      errors.add(:target_wallet, "No user is associated with the target wallet")
    end
  end

  def source_user_is_active
    if source_wallet.user && source_wallet.user.status != 'active'
      errors.add(:source_wallet, ResponseMessages.user_cant_send_fund("#{source_wallet.user.status}"))
    end
  end

  # Apply the transaction logic (debit or credit)
  def apply_transaction
    ActiveRecord::Base.transaction do
      # Lock both wallets
      source_wallet.with_lock do
        target_wallet.with_lock do
          if debit?
            source_wallet.adjust_balance(-amount)
            target_wallet.adjust_balance(amount) if target_wallet
          elsif credit?
            target_wallet.adjust_balance(amount)
          end

          # Rollback if saving fails
          raise ActiveRecord::Rollback unless source_wallet.save && (target_wallet.nil? || target_wallet.save)
        end
      end
    end
  end
end
