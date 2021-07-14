# frozen_string_literal: true

class FindUserQuery
  attr_reader :token

  def initialize(token = nil)
    @token = token
  end

  def call
    return search_by_token unless token.nil?

    nil
  end

  private

  def search_by_token
    User.find(token[:user_id])
  end
end
