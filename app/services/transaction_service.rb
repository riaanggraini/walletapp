class TransactionService
  def initialize(user, transaction_params)
    @user = user
    @transaction_params = transaction_params
  end

  def create_transaction
    # Find the wallets
    source_wallet = @user.wallet
    target_wallet = Wallet.find_by(id: @transaction_params[:target_wallet_id])

    # Create and save the transaction
    transaction = Transaction.new(
      source_wallet: source_wallet,
      target_wallet: target_wallet,
      amount: @transaction_params[:amount],
      transaction_type: 'debit'
    )

    if transaction.save
      { status: :created, message: ResponseMessages.created("Transaction"), data: { transaction: transaction } }
    else
      { status: :unprocessable_entity, message: transaction.errors.full_messages.first }
    end
  end
end
