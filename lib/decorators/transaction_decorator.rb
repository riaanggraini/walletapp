class TransactionDecorator
  def initialize(transaction)
    @transaction = transaction
  end

  def as_json(*)
    {
      id: @transaction.id,
      amount: adjusted_amount,
      transaction_type: @transaction.transaction_type,
      source_wallet_id: @transaction.source_wallet_id,
      target_wallet_id: @transaction.target_wallet_id,
      target_wallet_owner_name: @transaction.target_wallet&.user&.username,
      target_wallet_owner_email: @transaction.target_wallet&.user&.email,
      created_at: @transaction.created_at,
    }
  end

  private

  def adjusted_amount
    @transaction.debit? ? -@transaction.amount : @transaction.amount
  end
end
