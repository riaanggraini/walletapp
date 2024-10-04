module ResponseHelper
  def json_response(status:, message:, data: nil, errors: nil)
    response = {
      status: status,
      message: message
    }
    response[:data] = data if data.present?
    response[:errors] = errors if errors.present?
    
    render json: response, status: status
  end
end
