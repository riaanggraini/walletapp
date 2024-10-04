module AuthenticationHelper
  def authenticate_user
    token = request.headers['Authorization']

    if token.present? && valid_token?(token)
      user_id = @decoded_token['user_id']
      @current_user = User.find_by(id: user_id)

      if @current_user.nil?
        render_unauthorized(ResponseMessages::UNAUTHORIZED_USER_NOT_FOUND)
      end
    else
      render_unauthorized(ResponseMessages::UNAUTHORIZED_INVALID_TOKEN)
    end
  end

  private

  def valid_token?(token)
    # Check for valid token structure
    payload, signature = token.split('.')
    return false if payload.blank? || signature.blank?

    # Decode the payload and verify the signature
    begin
      secret_key = Rails.application.secret_key_base
      expected_signature = Digest::SHA256.hexdigest("#{Base64.urlsafe_decode64(payload)}#{secret_key}")

      if expected_signature == signature
        @decoded_token = JSON.parse(Base64.urlsafe_decode64(payload))
        return !token_expired?(@decoded_token['exp'])
      end
    rescue ArgumentError => e
      Rails.logger.error "Invalid token format: #{e.message}"
      return false
    end

    false
  end

  def token_expired?(exp)
    Time.now.to_i > exp
  end

  def render_unauthorized(message)
    render json: { status: 401, message: message }, status: :unauthorized
  end
end
