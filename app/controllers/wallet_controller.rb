require 'helpers/authentication_helper'

class WalletController < ApplicationController
  include AuthenticationHelper
  include ResponseMessages

  before_action :authenticate_user

  def balances
    wallet = @current_user.wallet
    if wallet
      render json: { status: :ok, message:  ResponseMessages.found("Balance") , data: wallet }
    else
      render json: { status: :not_found, message: ResponseMessages.not_found("Balance") }
    end
  end
end
