module ResponseHelper
  def json_response(status:, message:, data: nil, errors: nil, pagination: nil)
    response = {
      status: status,
      message: message
    }
    response[:data] = data if data.present?
    response[:errors] = errors if errors.present?
    response[:pagination] = pagination if pagination.present?
    
    render json: response, status: status
  end
end
