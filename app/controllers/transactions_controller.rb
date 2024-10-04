require 'helpers/authentication_helper'

class TransactionsController < ApplicationController
  include AuthenticationHelper
  include ResponseMessages

  before_action :authenticate_user

  def transfer
    # Validate required parameters
    if transaction_params[:target_wallet_id].blank?
      return json_response(status: :bad_request, message: ResponseMessages.missing_value("Target wallet ID"))
    end

    if transaction_params[:amount].blank?
      return json_response(status: :bad_request, message: ResponseMessages.missing_value("Amount"))
    end

    # Check if the target wallet exists
    target_wallet = Wallet.find_by(id: transaction_params[:target_wallet_id])
    if target_wallet.nil?
      return json_response(status: :not_found, message: ResponseMessages.not_found("Target Wallet"))
    end

    # Call the service to create the transaction
    service = TransactionService.new(@current_user)
    result = service.create_transaction(transaction_params)

    json_response(status: result[:status], message: result[:message], data: result[:data])
  end

  def history
    service = TransactionService.new(@current_user)
    result = service.get_transaction_history(params)
    json_response(
      status: result[:status],
      message: result[:message],
      data: result[:data],
      pagination: result[:pagination]
    )
  end

  private

  def transaction_params
    params.require(:transaction).permit(:target_wallet_id, :amount)
  end
end
