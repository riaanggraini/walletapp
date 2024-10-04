require 'decorators/transaction_decorator'
require 'helpers/pagination_helper'

class TransactionService
  include PaginationHelper
  def initialize(user)
    @user = user
  end

  def create_transaction(transaction_params)
    # Find the wallets
    source_wallet = @user.wallet
    target_wallet = Wallet.find_by(id: transaction_params[:target_wallet_id])

    # Create and save the transaction
    transaction = Transaction.new(
      source_wallet: source_wallet,
      target_wallet: target_wallet,
      amount: transaction_params[:amount],
      transaction_type: 'debit'
    )

    if transaction.save
      { status: :created, message: ResponseMessages.created("Transaction"), data: { transaction: transaction } }
    else
      { status: :unprocessable_entity, message: transaction.errors.full_messages.first }
    end
  end

  def get_transaction_history(params)
    user_wallet = @user.wallet
  
    transactions = Transaction.includes(target_wallet: :user).where(source_wallet: user_wallet).or(Transaction.where(target_wallet: user_wallet)).order(created_at: :desc)
    result = paginate(transactions, params[:page], params[:per_page])

    if result[:collection].any?
      # Format the response data using your TransactionDecorator
      transaction_data = result[:collection].map { |transaction| TransactionDecorator.new(transaction).as_json }

      return {
        status: :ok,
        message: ResponseMessages.found("Transactions"),
        data: transaction_data,
        pagination: result[:pagination]
      }

    else
      { status: :not_found, message: ResponseMessages.not_found("Transactions") }
    end
  end
end
