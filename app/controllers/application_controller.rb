require 'helpers/response_helper'
require 'helpers/response_messages'

class ApplicationController < ActionController::API
  include ResponseHelper
  include ResponseMessages
end
