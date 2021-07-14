# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ExceptionHandler
  include Response

  attr_reader :current_user

  # called before every action on controllers
  before_action :authorize_request

  # Check for valid request token and return user
  def authorize_request
    @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
  end
end
