require Rails.root.join('lib/helpers/response_helper.rb')
require Rails.root.join('lib/helpers/response_messages.rb')

class ApplicationController < ActionController::API
  include ResponseHelper
  include ResponseMessages
end
