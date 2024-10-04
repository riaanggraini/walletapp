require Rails.root.join('lib/helpers/authentication_helper.rb')

class TransactionsController < ApplicationController
  include AuthenticationHelper

  # Authentication Helpers
  before_action :authenticate_user

  def create
    # Validate required parameters
    if transaction_params[:target_wallet_id].blank?
      return json_response(status: :bad_request, message: ResponseMessages.missing_value("Target wallet ID"))
    end
    
    if transaction_params[:amount].blank?
      return json_response(status: :bad_request, message: ResponseMessages.missing_value("Amount"))
    end
    
    if transaction_params[:transaction_type].blank?
      return json_response(status: :bad_request, message: ResponseMessages.missing_value("Transaction type"))
    end    

    # Find source and target wallets
    source_wallet = @current_user.wallet
    target_wallet = Wallet.find_by(id: transaction_params[:target_wallet_id])

    if target_wallet.nil?
      return json_response(status: :not_found, message: ResponseMessages.not_found("Target Wallet"))
    end

    # Create transaction
    transaction = Transaction.new(
      source_wallet: source_wallet,
      target_wallet: target_wallet,
      amount: transaction_params[:amount],
      transaction_type: transaction_params[:transaction_type]
    )

    if transaction.save
      json_response(status: :created, message: ResponseMessages.created("Transaction"), data: { transaction: transaction })
    else
      json_response(status: :unprocessable_entity, message: transaction.errors.full_messages.first)
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:target_wallet_id, :amount, :transaction_type)
  end
end