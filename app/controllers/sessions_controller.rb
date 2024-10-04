require 'securerandom'
require 'digest'

class SessionsController < ApplicationController
  include ResponseMessages

  def create
    # validations
    if session_params[:email].blank? || session_params[:password].blank?
      json_response(status: :bad_request, message: MISSING_EMAIL_PASSWORD)
      return
    end

    # Find user by Email
    user = User.find_by(email: session_params[:email])

    # Authenticate user
    if user && user.authenticate(session_params[:password])
      token = generate_secure_token(user)
      # Return success response
      json_response(status: :ok, message: LOGIN_SUCCESS, data: { token: token })
    else
      # Return error response
      json_response(status: :unauthorized, message: LOGIN_FAILED)
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end

  def generate_secure_token(user)
    # Generate random string
    random_string = SecureRandom.hex(32)
    
    # Prepare payloads
    payload = {
      user_id: user.id,
      exp: Time.now.to_i + 3600,
      nonce: random_string,
    }
    payload_string = payload.to_json

    # Generate signature with SHA256
    secret_key = Rails.application.secret_key_base
    signature = Digest::SHA256.hexdigest("#{payload_string}#{secret_key}")

    # Generate token
    token = "#{Base64.urlsafe_encode64(payload_string)}.#{signature}"

    token
  end
end
